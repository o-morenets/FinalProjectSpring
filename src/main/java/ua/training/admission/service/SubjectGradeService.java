package ua.training.admission.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ua.training.admission.entity.*;
import ua.training.admission.repository.SubjectGradeRepository;
import ua.training.admission.repository.UserRepository;

import java.util.List;
import java.util.Map;

import static java.util.stream.Collectors.partitioningBy;

@Slf4j
@Service
public class SubjectGradeService {

    private final SubjectGradeRepository subjectGradeRepository;
    private final UserRepository userRepository;

    @Autowired
    public SubjectGradeService(SubjectGradeRepository subjectGradeRepository, UserRepository userRepository) {
        this.subjectGradeRepository = subjectGradeRepository;
        this.userRepository = userRepository;
    }

    public List<SubjectGrade> findUserSubjectGrades(User user) {
        return subjectGradeRepository.findUserSubjectGrades(user.getId());
    }

    public void updateGrades(User user, Map<String, String> form) {
        Map<Boolean, List<SubjectGrade>> subjectGradeMap = partitionSubjectGrades(user, form);
        List<SubjectGrade> subjectGradesToUpdate = subjectGradeMap.get(Boolean.TRUE);
        List<SubjectGrade> subjectGradesToDelete = subjectGradeMap.get(Boolean.FALSE);

        updateAndDelete(user, subjectGradesToUpdate, subjectGradesToDelete);
    }

    @Transactional
    void updateAndDelete(User user,
                         List<SubjectGrade> subjectGradesToUpdate,
                         List<SubjectGrade> subjectGradesToDelete) {

        subjectGradeRepository.saveAll(subjectGradesToUpdate);
        subjectGradeRepository.deleteAll(subjectGradesToDelete);

        updateUserMessage(user, subjectGradesToUpdate, subjectGradesToDelete);
    }

    private Map<Boolean, List<SubjectGrade>> partitionSubjectGrades(User user, Map<String, String> form) {
        return form.entrySet().stream()
                .filter(entry -> entry.getKey().startsWith("subject_"))
                .map(entry -> SubjectGrade.builder()
                        .id(new UserSubjectGradeKey(
                                user.getId(),
                                Long.valueOf(entry.getKey().replaceAll("\\D+", ""))))
                        .user(User.builder()
                                .id(user.getId())
                                .build())
                        .subject(Subject.builder()
                                .id(Long.valueOf(entry.getKey().replaceAll("\\D+", "")))
                                .build())
                        .grade(entry.getValue().isEmpty() ? null : Integer.parseInt(entry.getValue()))
                        .build())
                .collect(partitioningBy(subjectGrade -> subjectGrade.getGrade() != null));
    }

    private void updateUserMessage(User user,
                                   List<SubjectGrade> subjectGradesToUpdate,
                                   List<SubjectGrade> subjectGradesToDelete) {

        Message message = user.getMessage();
        if (message == null) {
            message = Message.builder()
                    .user(user)
                    .build();
        }

        boolean isAllGradesProvided = subjectGradesToDelete.isEmpty();
        if (isAllGradesProvided) {
            message.setAverageGrade(countAverageGrade(subjectGradesToUpdate));
        } else {
            message = null;
        }

        user.setMessage(message);
        userRepository.save(user);
    }

    private double countAverageGrade(List<SubjectGrade> subjectGradesFinal) {
        return subjectGradesFinal.stream()
                .mapToDouble(SubjectGrade::getGrade)
                .average()
                .orElse(-1); // TODO maybe orElseThrow and then catch ???
    }
}
