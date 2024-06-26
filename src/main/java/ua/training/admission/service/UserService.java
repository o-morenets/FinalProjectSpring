package ua.training.admission.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedExceptionUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Slice;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ua.training.admission.entity.*;
import ua.training.admission.exception.NotUniqueUsernameException;
import ua.training.admission.repository.SpecialityRepository;
import ua.training.admission.repository.UserRepository;

import java.sql.SQLException;
import java.util.*;

@Slf4j
@Service
public class UserService {

    private static final int SQL_CONSTRAINT_NOT_UNIQUE = 1062;

    private final UserRepository userRepository;
    private final SpecialityRepository specialityRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserService(UserRepository userRepository, SpecialityRepository specialityRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.specialityRepository = specialityRepository;
        this.passwordEncoder = passwordEncoder;
    }

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

        } catch (Exception e) {
            int errorCode = 0;

            Throwable specificException = NestedExceptionUtils.getMostSpecificCause(e);

            if (specificException instanceof SQLException) {
                SQLException sqlException = (SQLException) specificException;
                errorCode = sqlException.getErrorCode();
            }

            if (errorCode == SQL_CONSTRAINT_NOT_UNIQUE) {
                throw new NotUniqueUsernameException("User already exists");
            }

            throw e;
        }
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
