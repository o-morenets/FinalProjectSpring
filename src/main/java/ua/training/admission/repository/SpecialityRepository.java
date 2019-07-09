package ua.training.admission.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ua.training.admission.entity.Speciality;

@Repository
public interface SpecialityRepository extends JpaRepository<Speciality, Long> {

}
