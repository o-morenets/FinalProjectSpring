package ua.training.admission.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ua.training.admission.entity.Subject;
import ua.training.admission.entity.SubjectGrade;
import ua.training.admission.entity.User;

import java.util.List;

@Repository
public interface SubjectGradeRepository extends JpaRepository<SubjectGrade, Long> {

    List<SubjectGrade> findByUser(User user);

}
