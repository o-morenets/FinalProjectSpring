package ua.training.admission.entity;

import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.util.Set;

@Data
@EqualsAndHashCode(exclude = {"specialities", "grades"})
@ToString(exclude = {"specialities", "grades"})
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Subject {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @OneToMany(mappedBy = "subject")
    private Set<SubjectGrade> grades;

    @ManyToMany(mappedBy = "subjects")
    private Set<Speciality> specialities;
}
