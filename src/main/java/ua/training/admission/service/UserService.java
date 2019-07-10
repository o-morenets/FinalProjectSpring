package ua.training.admission.service;

import com.google.common.collect.ImmutableList;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedExceptionUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import ua.training.admission.dto.UserLoginDTO;
import ua.training.admission.dto.UserSignupDTO;
import ua.training.admission.entity.Role;
import ua.training.admission.entity.User;
import ua.training.admission.exception.NotUniqueLoginException;
import ua.training.admission.repository.UserRepository;

import java.sql.SQLException;
import java.util.Optional;

@Slf4j
@Service
public class UserService {

    private static final int SQL_CONSTRAINT_NOT_UNIQUE = 1062;

    private UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public Optional<User> login(UserLoginDTO userLoginDTO) {
        User user = userRepository.findByUsername(userLoginDTO.getUsername());
        return Optional.of(user);
    }

    public void saveNewUser(UserSignupDTO userSignupDTO) {
        User user = User.builder()
                .username(userSignupDTO.getUsername())
                .password(new BCryptPasswordEncoder().encode(userSignupDTO.getPassword()))
                .authorities(ImmutableList.of(Role.ROLE_USER))
                .accountNonExpired(true)
                .accountNonLocked(true)
                .credentialsNonExpired(true)
                .enabled(true)
                .firstName(userSignupDTO.getFirstName())
                .lastName(userSignupDTO.getLastName())
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
                throw new NotUniqueLoginException("Email already exists", userSignupDTO);
            }

            throw ex;
        }
    }
}
