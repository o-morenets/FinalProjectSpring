package ua.training.admission.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class SubjectGrade {

    @EmbeddedId
    private UserSubjectGradeKey id;

    @ManyToOne()
    @MapsId("userId")
    private User user;

    @ManyToOne()
    @MapsId("subjectId")
    private Subject subject;

    private int grade;
}