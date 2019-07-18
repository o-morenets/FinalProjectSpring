package ua.training.admission.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ua.training.admission.entity.Subject;
import ua.training.admission.entity.SubjectGrade;
import ua.training.admission.entity.User;

import java.util.List;
import java.util.stream.Collectors;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SubjectGradeDto {

    private Subject subject;
    private int grade;

    public static List<SubjectGradeDto> getUserGradeDtos(List<SubjectGrade> subjectGrades) {
        return subjectGrades.stream()
                .map(subjectGrade -> SubjectGradeDto.builder()
                        .subject(subjectGrade.getSubject())
                        .grade(subjectGrade.getGrade())
                        .build())
                .collect(Collectors.toList());
    }
}
