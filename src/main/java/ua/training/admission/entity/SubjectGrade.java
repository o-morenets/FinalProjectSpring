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
    UserGradeKey id;

    @ManyToOne
    @MapsId("user_id")
    @JoinColumn(name = "user_id")
    User user;

    @ManyToOne
    @MapsId("subject_id")
    @JoinColumn(name = "subject_id")
    Subject subject;

    int grade;
}