package ua.training.admission.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedExceptionUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import ua.training.admission.entity.Role;
import ua.training.admission.entity.Speciality;
import ua.training.admission.entity.User;
import ua.training.admission.exception.NotUniqueUsernameException;
import ua.training.admission.repository.SpecialityRepository;
import ua.training.admission.repository.UserRepository;

import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class UserService {

    private static final int SQL_CONSTRAINT_NOT_UNIQUE = 1062;

    private final UserRepository userRepository;
    private final SpecialityRepository specialityRepository;

    @Autowired
    public UserService(UserRepository userRepository, SpecialityRepository specialityRepository) {
        this.userRepository = userRepository;
        this.specialityRepository = specialityRepository;
    }

    public List<User> findAllByRole(Role role) {
        return userRepository.findByAuthoritiesContains(role);
    }

    public Optional<User> getOne(Long id) {
        return Optional.of(userRepository.getOne(id));
    }

    public void createUser(User userDto) {
        User user = User.builder()
                .username(userDto.getUsername())
                .password(new BCryptPasswordEncoder().encode(userDto.getPassword()))
                .email(userDto.getEmail())
                .authorities(Collections.singleton(Role.USER))
                .accountNonExpired(true)
                .accountNonLocked(true)
                .credentialsNonExpired(true)
                .enabled(true)
                .firstName(userDto.getFirstName())
                .lastName(userDto.getLastName())
                .build();

        try {
            userRepository.save(user);

        } catch (Exception ex) {
            int errorCode = 0;

            Throwable specificException = NestedExceptionUtils.getMostSpecificCause(ex);

            if (specificException instanceof SQLException) {
                SQLException sqlException = (SQLException) specificException;
                errorCode = sqlException.getErrorCode();
            }

            if (errorCode == SQL_CONSTRAINT_NOT_UNIQUE) {
                log.warn("User already exists");

                throw new NotUniqueUsernameException("User already exists");
            }

            throw ex;
        }
    }

    public void updateSpeciality(User user, Long specId) {
        Optional<Speciality> speciality = specialityRepository.findById(specId);
        user.setSpeciality(speciality.orElse(null));
        userRepository.save(user);
    }
}
