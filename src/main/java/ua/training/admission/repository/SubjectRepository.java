package ua.training.admission.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ua.training.admission.entity.Subject;
import ua.training.admission.entity.User;

@Repository
public interface SubjectRepository extends JpaRepository<Subject, Long> {

}
