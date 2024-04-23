package ua.training.admission.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import ua.training.admission.entity.Speciality;

import java.util.List;

@Repository
public interface SpecialityRepository extends JpaRepository<Speciality, Long> {

    @Query("select distinct spec from Speciality spec join fetch spec.subjects")
    List<Speciality> findAll();
}
