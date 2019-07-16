package ua.training.admission.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import ua.training.admission.entity.User;
import ua.training.admission.exception.ResourceNotFoundException;
import ua.training.admission.repository.SpecialityRepository;
import ua.training.admission.repository.UserRepository;

import javax.validation.Valid;

@Controller
@RequestMapping("specialities")
public class SpecialityUserController {

    private final UserRepository userRepository;
    private final SpecialityRepository specialityRepository;

    @Autowired
    public SpecialityUserController(UserRepository userRepository, SpecialityRepository specialityRepository) {
        this.userRepository = userRepository;
        this.specialityRepository = specialityRepository;
    }

    @GetMapping("{specialityId}/users")
    public Page<User> getAllUsersBySpecialityId(@PathVariable(value = "specialityId") Long specialityId,
                                                Pageable pageable) {
        
        return userRepository.findBySpecialityId(specialityId, pageable);
    }

    @PostMapping(value = "{specialityId}/users",
            consumes = MediaType.APPLICATION_JSON_UTF8_VALUE,
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public User createUser(@PathVariable(value = "specialityId") Long specialityId,
                                 @Valid @RequestBody User user) {

        return specialityRepository.findById(specialityId).map(speciality -> {
            user.setSpeciality(speciality);
            return userRepository.save(user);
        }).orElseThrow(() -> new ResourceNotFoundException("SpecialityId " + specialityId + " not found"));
    }

    @PutMapping("{specialityId}/users/{userId}")
    public User updateUser(@PathVariable(value = "specialityId") Long specialityId,
                                 @PathVariable(value = "userId") Long userId,
                                 @Valid @RequestBody User userRequest) {

        if (!specialityRepository.existsById(specialityId)) {
            throw new ResourceNotFoundException("SpecialityId " + specialityId + " not found");
        }

        return userRepository.findById(userId).map(user -> {
            user.setSpeciality(userRequest.getSpeciality());
            return userRepository.save(user);
        }).orElseThrow(() -> new ResourceNotFoundException("UserId " + userId + "not found"));
    }

    @DeleteMapping("{specialityId}/users/{userId}")
    public ResponseEntity<?> deleteUser(@PathVariable(value = "specialityId") Long specialityId,
                                           @PathVariable(value = "userId") Long userId) {

        return userRepository.findByIdAndSpecialityId(userId, specialityId).map(user -> {
            userRepository.delete(user);
            return ResponseEntity.ok().build();
        }).orElseThrow(() -> new ResourceNotFoundException("User not found with id " + userId + " and specialityId " + specialityId));
    }
}