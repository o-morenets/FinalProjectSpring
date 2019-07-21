package ua.training.admission.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ua.training.admission.entity.Subject;
import ua.training.admission.entity.SubjectGrade;
import ua.training.admission.entity.User;
import ua.training.admission.entity.UserSubjectGradeKey;
import ua.training.admission.repository.SubjectGradeRepository;
import ua.training.admission.repository.SubjectRepository;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Service
public class SubjectGradeService {

    private final SubjectGradeRepository subjectGradeRepository;

    @Autowired
    public SubjectGradeService(SubjectGradeRepository subjectGradeRepository) {
        this.subjectGradeRepository = subjectGradeRepository;
    }

    public List<SubjectGrade> getUserGrades(User user) {
        return subjectGradeRepository.findByUser(user);
    }

    public void updateGrades(User user, Map<String, String> form) {
        subjectGradeRepository.saveAll(form.entrySet().stream()
                .filter(entry -> entry.getKey().startsWith("subject_"))
                .filter(entry -> !entry.getValue().isEmpty()) // TODO What to do with empty ???
                .map(entry -> SubjectGrade.builder()
                        .id(new UserSubjectGradeKey(
                                user.getId(),
                                Long.valueOf(entry.getKey().replace("subject_", ""))))
                        .user(User.builder()
                                .id(user.getId())
                                .build())
                        .subject(Subject.builder()
                                .id(Long.valueOf(entry.getKey().replace("subject_", "")))
                                .build())
                        .grade(Integer.parseInt(entry.getValue()))
                        .build())
                .collect(Collectors.toList()));
    }
}
