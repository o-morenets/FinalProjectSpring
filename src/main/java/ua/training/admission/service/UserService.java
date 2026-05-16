package ua.training.admission.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
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
            userRepository.saveAndFlush(usr);
        } catch (DataIntegrityViolationException e) {
            throw new NotUniqueUsernameException("User already exists");
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
