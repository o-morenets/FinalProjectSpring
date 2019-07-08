package ua.training.admission.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import ua.training.admission.entity.Subject;

import java.util.Optional;

public interface SubjectRepository extends JpaRepository<Subject, Long> {

    Page<Subject> findByUserUserId(Long userId, Pageable pageable);

    Optional<Subject> findBySubjectIdAndUserUserId(Long subjectId, Long userId);
}
