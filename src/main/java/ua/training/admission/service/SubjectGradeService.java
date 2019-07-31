package ua.training.admission.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ua.training.admission.entity.Subject;
import ua.training.admission.entity.SubjectGrade;
import ua.training.admission.entity.User;
import ua.training.admission.entity.UserSubjectGradeKey;
import ua.training.admission.repository.SubjectGradeRepository;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static java.util.stream.Collectors.partitioningBy;

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
        Map<Boolean, List<SubjectGrade>> subjectGradeMap = getBooleanListMap(user, form);
        updateAndDelete(subjectGradeMap);
    }

    private Map<Boolean, List<SubjectGrade>> getBooleanListMap(User user, Map<String, String> form) {
        return form.entrySet().stream()
                    .filter(entry1 -> entry1.getKey().startsWith("subject_"))
                    .map(entry1 -> SubjectGrade.builder()
                            .id(new UserSubjectGradeKey(
                                    user.getId(),
                                    Long.valueOf(entry1.getKey().replaceAll("\\D+", ""))))
                            .user(User.builder()
                                    .id(user.getId())
                                    .build())
                            .subject(Subject.builder()
                                    .id(Long.valueOf(entry1.getKey().replaceAll("\\D+", "")))
                                    .build())
                            .grade(entry1.getValue().isEmpty() ? null : Integer.parseInt(entry1.getValue()))
                            .build())
                    .collect(partitioningBy(subjectGrade -> subjectGrade.getGrade() != null));
    }

    @Transactional
    private void updateAndDelete(Map<Boolean, List<SubjectGrade>> subjectGradeMap) {
        subjectGradeRepository.saveAll(subjectGradeMap.get(true));
        subjectGradeRepository.deleteAll(subjectGradeMap.get(false));
    }
}
