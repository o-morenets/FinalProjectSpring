package ua.training.admission.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Slice;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ua.training.admission.entity.Role;
import ua.training.admission.entity.Speciality;
import ua.training.admission.entity.User;
import ua.training.admission.exception.NotUniqueUsernameException;
import ua.training.admission.repository.SpecialityRepository;
import ua.training.admission.repository.UserRepository;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final SpecialityRepository specialityRepository;
    private final PasswordEncoder passwordEncoder;

    public List<User> findAllByRole(Role role) {
        return userRepository.findByAuthoritiesContains(role);
    }

    public Slice<User> findAllByRole(Role role, int page, int size) {
        return userRepository.findByAuthoritiesContains(role, PageRequest.of(page, size));
    }

    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }

    public void createUser(User user) {
        User usr = User.builder()
                .username(user.getUsername())
                .password(passwordEncoder.encode(user.getPassword()))
                .email(user.getEmail())
                .authorities(Collections.singleton(Role.USER))
                .accountNonExpired(true)
                .accountNonLocked(true)
                .credentialsNonExpired(true)
                .enabled(true)
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .build();

        try {
            userRepository.save(usr);

        } catch (DataIntegrityViolationException e) {
            if (isDuplicateKeyException(e)) {
                throw new NotUniqueUsernameException("User already exists");
            }
            // Re-throw other types of exceptions
            throw e;
        }
    }

    private boolean isDuplicateKeyException(DataIntegrityViolationException ex) {
        // This method can be more specific depending on the underlying database.
        // For example, with MySQL you may inspect the SQLState or ErrorCode.
        return ex.getCause() instanceof org.hibernate.exception.ConstraintViolationException;
    }

    public void updateSpeciality(User user, Long specId) {
        Optional<Speciality> speciality = specialityRepository.findById(specId);
        speciality.ifPresent(user::setSpeciality);
        userRepository.save(user);
    }

    @Transactional
    public void sendMessages(Double passGrade) {
        List<User> users = userRepository.findByAuthoritiesContains(Role.USER);
        users.stream()
                .filter(user -> user.getMessage() != null)
                .forEach(user -> {
                    user.getMessage().setEntered(user.getMessage().getAverageGrade() >= passGrade);
                });
        userRepository.saveAll(users);
    }
}
