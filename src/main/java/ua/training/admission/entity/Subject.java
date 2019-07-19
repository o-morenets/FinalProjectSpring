package ua.training.admission.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Subject {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String name;

    @OneToMany(mappedBy = "subject", fetch = FetchType.LAZY)
    private Set<SubjectGrade> grades;

    @ManyToMany(mappedBy = "subjects", fetch = FetchType.LAZY)
    private Set<Speciality> specialities;
}
