package ua.training.admission.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedExceptionUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import ua.training.admission.entity.Role;
import ua.training.admission.entity.Speciality;
import ua.training.admission.entity.User;
import ua.training.admission.entity.dto.UserSignupDto;
import ua.training.admission.repository.SpecialityRepository;
import ua.training.admission.repository.UserRepository;

import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.Map;
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

    public boolean createUser(UserSignupDto userSignupDto) {
        User user = User.builder()
                .username(userSignupDto.getUsername())
                .password(new BCryptPasswordEncoder().encode(userSignupDto.getPassword()))
                .email(userSignupDto.getEmail())
                .authorities(Collections.singleton((Role.USER)))
                .accountNonExpired(true)
                .accountNonLocked(true)
                .credentialsNonExpired(true)
                .enabled(true)
                .firstName(userSignupDto.getFirstName())
                .lastName(userSignupDto.getLastName())
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
                log.warn("Email already exists");

                return false;
            }

            throw ex;
        }

        return true;
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public void updateProfile(User user, String email, String lastName, String firstName) {
        user.setEmail(email);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        userRepository.save(user);
    }

    public void saveUser(User user, Map<String, String> form) {
        Optional<Speciality> speciality = Optional.empty();
        for (String key : form.keySet()) {
            final String spec_ = "spec_";
            if (key.startsWith(spec_)) {
                Long id = Long.parseLong(key.replace(spec_, ""));
                speciality = specialityRepository.findById(id);
                break;
            }
        }
        user.setSpeciality(speciality.orElse(null));
        userRepository.save(user);
    }
}
