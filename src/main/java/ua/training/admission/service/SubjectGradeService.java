package ua.training.admission.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ua.training.admission.entity.SubjectGrade;
import ua.training.admission.entity.User;
import ua.training.admission.entity.dto.SubjectGradeDto;
import ua.training.admission.repository.SubjectGradeRepository;

import java.util.List;
import java.util.stream.Collectors;

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
}
