package ua.training.admission.entity;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
public class UserSubjectGradeKey implements Serializable {

    @Column(name = "user_id")
    private Long userId;

    @Column(name = "subject_id")
    private Long subjectId;
}
