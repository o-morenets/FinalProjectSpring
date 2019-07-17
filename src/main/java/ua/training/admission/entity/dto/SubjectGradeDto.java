package ua.training.admission.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ua.training.admission.entity.Subject;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SubjectGradeDto {

    private Subject subject;
    private int grade;
}
