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
    private UserGradeKey id;

    @ManyToOne
    @MapsId("user_id")
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @MapsId("subject_id")
    @JoinColumn(name = "subject_id")
    private Subject subject;

    private int grade;
}