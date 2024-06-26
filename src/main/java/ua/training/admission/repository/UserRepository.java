package ua.training.admission.repository;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ua.training.admission.entity.Role;
import ua.training.admission.entity.User;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByUsername(String username);

    List<User> findByAuthoritiesContains(Role role);

    Slice<User> findByAuthoritiesContains(Role role, Pageable pageable);

}
