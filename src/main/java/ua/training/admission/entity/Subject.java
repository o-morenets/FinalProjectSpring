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

    @OneToMany(mappedBy = "subject")
    private Set<SubjectGrade> grades;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "speciality_id")
    @OnDelete(action = OnDeleteAction.CASCADE)
    private Speciality speciality;
}
