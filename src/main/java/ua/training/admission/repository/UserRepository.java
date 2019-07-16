package ua.training.admission.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ua.training.admission.entity.User;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    User findByUsername(String username); // FIXME Optional

    Page<User> findBySpecialityId(Long specialityId, Pageable pageable);

    Optional<User> findByIdAndSpecialityId(Long id, Long specialityId);

}
