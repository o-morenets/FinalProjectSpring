package ua.training.admission.entity.dto;

import lombok.Builder;
import lombok.Getter;
import ua.training.admission.entity.Subject;
import ua.training.admission.entity.SubjectGrade;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Getter
@Builder
public class SubjectGradeDto {

    private String name;
    private Integer grade;

    public static List<SubjectGradeDto> getSubjectGradeDtoList(List<Subject> subjects, List<SubjectGrade> subjectGrades) {
        final Map<Long, Integer> subjectGradeMap = subjectGrades.stream()
                .collect(Collectors.toMap(subjectGrade -> subjectGrade.getSubject().getId(), SubjectGrade::getGrade));

        return subjects.stream()
                .map(subject -> SubjectGradeDto.builder()
                        .name(subject.getName())
                        .grade(subjectGradeMap.get(subject.getId()))
                        .build())
                .collect(Collectors.toList());
    }
}
