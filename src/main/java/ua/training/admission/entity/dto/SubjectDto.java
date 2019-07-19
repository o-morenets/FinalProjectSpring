package ua.training.admission.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ua.training.admission.entity.Subject;
import ua.training.admission.entity.SubjectGrade;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SubjectDto {

    private String name;
    private Integer grade;

    public static List<SubjectDto> getSubjectDtoList(List<Subject> subjects, List<SubjectGrade> subjectGrades) {
        final Map<Long, Integer> subjectGradeMap = subjectGrades.stream()
                .collect(Collectors.toMap(subjectGrade -> subjectGrade.getSubject().getId(), SubjectGrade::getGrade));

        return subjects.stream()
                .map(subject -> SubjectDto.builder()
                        .name(subject.getName())
                        .grade(subjectGradeMap.get(subject.getId()))
                        .build())
                .collect(Collectors.toList());
    }
}
