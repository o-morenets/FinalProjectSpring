package ua.training.admission.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ua.training.admission.entity.Subject;
import ua.training.admission.exception.ResourceNotFoundException;
import ua.training.admission.repository.SubjectRepository;
import ua.training.admission.repository.UserRepository;

import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.Produces;

@RestController
public class SubjectController {

    private final SubjectRepository subjectRepository;

    private final UserRepository userRepository;

    @Autowired
    public SubjectController(SubjectRepository subjectRepository, UserRepository userRepository) {
        this.subjectRepository = subjectRepository;
        this.userRepository = userRepository;
    }

    @GetMapping("/users/{userId}/subjects")
    public Page<Subject> getAllSubjectsByUserId(@PathVariable(value = "userId") Long userId, Pageable pageable) {
        return subjectRepository.findByUserUserId(userId, pageable);
    }

    @PostMapping("/users/{userId}/subjects")
    @Produces(MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Subject createSubject(@PathVariable (value = "userId") Long userId, @Valid @RequestBody Subject subject) {
        return userRepository.findById(userId).map(user -> {
            subject.setUser(user);
            return subjectRepository.save(subject);
        }).orElseThrow(() -> new ResourceNotFoundException("UserId " + userId + " not found"));
    }

    @PutMapping("/users/{userId}/subjects/{subjectId}")
    public Subject updateSubject(@PathVariable (value = "userId") Long userId,
                                 @PathVariable (value = "subjectId") Long subjectId,
                                 @Valid @RequestBody Subject subjectRequest) {
        if(!userRepository.existsById(userId)) {
            throw new ResourceNotFoundException("UserId " + userId + " not found");
        }

        return subjectRepository.findById(subjectId).map(subject -> {
            subject.setSubjectName(subjectRequest.getSubjectName());
            return subjectRepository.save(subject);
        }).orElseThrow(() -> new ResourceNotFoundException("SubjectId " + subjectId + "not found"));
    }

    @DeleteMapping("/users/{userId}/subjects/{subjectId}")
    public ResponseEntity<?> deleteSubject(@PathVariable (value = "userId") Long userId,
                                           @PathVariable (value = "subjectId") Long subjectId) {
        return subjectRepository.findBySubjectIdAndUserUserId(subjectId, userId).map(subject -> {
            subjectRepository.delete(subject);
            return ResponseEntity.ok().build();
        }).orElseThrow(() -> new ResourceNotFoundException("Subject not found with id " + subjectId + " and userId " + userId));
    }
}

