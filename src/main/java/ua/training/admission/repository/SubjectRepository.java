package ua.training.admission.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ua.training.admission.entity.Speciality;
import ua.training.admission.entity.Subject;

import java.util.List;
import java.util.Set;

@Repository
public interface SubjectRepository extends JpaRepository<Subject, Long> {

    List<Subject> findBySpecialities(Set<Speciality> specialities);

}
