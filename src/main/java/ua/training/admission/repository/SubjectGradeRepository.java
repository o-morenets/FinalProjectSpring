package ua.training.admission.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ua.training.admission.entity.SubjectGrade;

import java.util.List;

@Repository
public interface SubjectGradeRepository extends JpaRepository<SubjectGrade, Long> {

    @Query(nativeQuery = true,
            value = "SELECT usr.id user_id, subject.id subject_id, subject_grade.grade" +
                    " FROM usr" +
                    " JOIN speciality" +
                    " ON usr.speciality_id = speciality.id" +
                    " JOIN speciality_subject" +
                    " ON speciality_subject.speciality_id = speciality.id" +
                    " LEFT JOIN subject" +
                    " ON speciality_subject.subject_id = subject.id" +
                    " LEFT JOIN subject_grade" +
                    " ON subject_grade.subject_id = subject.id AND subject_grade.user_id = usr.id" +
                    " WHERE usr.id = :userId")
    List<SubjectGrade> findUserSubjectGrades(@Param("userId") Long userId);

}
