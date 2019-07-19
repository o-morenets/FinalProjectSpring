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

    @Query(value = "SELECT sg.* " +
                    "FROM usr u " +
                    "JOIN speciality sp " +
                    "ON u.speciality_id = sp.id " +
                    "LEFT JOIN speciality_subject ss " +
                    "ON ss.speciality_id = sp.id " +
                    "LEFT JOIN `subject` sub " +
                    "ON ss.subject_id = sub.id " +
                    "LEFT JOIN subject_grade sg " +
                    "ON sg.subject_id = sub.id AND sg.user_id = u.id " +
                    "WHERE u.id = :userId",
            nativeQuery = true)
    List<SubjectGrade> findByUser(@Param("userId") Long userId);

    List<SubjectGrade> findByUser(User user);

}
