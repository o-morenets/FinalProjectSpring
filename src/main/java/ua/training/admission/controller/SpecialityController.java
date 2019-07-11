package ua.training.admission.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import ua.training.admission.entity.Speciality;
import ua.training.admission.exception.ResourceNotFoundException;
import ua.training.admission.repository.SpecialityRepository;
import ua.training.admission.repository.UserRepository;

import javax.validation.Valid;

@Slf4j
@Controller
@RequestMapping("/spec")
public class SpecialityController {

    private final SpecialityRepository specialityRepository;

    @Autowired
    public SpecialityController(SpecialityRepository specialityRepository) {
        this.specialityRepository = specialityRepository;
    }

    @GetMapping
    public Page<Speciality> getAllSpecialities(Pageable pageable) {
        return specialityRepository.findAll(pageable);
    }

    @GetMapping("{specId}")
    public Speciality getOneSpeciality(@PathVariable Long specId) {
        return specialityRepository.findById(specId)
                .orElseThrow(() -> new ResourceNotFoundException("specId " + specId + " not found"));
    }

    @PostMapping(produces = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public Speciality createSpeciality(@RequestBody Speciality speciality) {
        log.info(speciality.toString());
        return specialityRepository.save(speciality);
    }

// TODO 2 return
    @PutMapping("{specId}")
    public Speciality updateSpeciality(@PathVariable Long specId, @Valid @RequestBody Speciality specialityRequest) {
        return specialityRepository.findById(specId).map(speciality -> {
            speciality.setName(specialityRequest.getName());
            return specialityRepository.save(speciality);
        }).orElseThrow(() -> new ResourceNotFoundException("specId " + specId + " not found"));
    }

    @DeleteMapping("{specId}")
    public ResponseEntity<?> deleteSpeciality(@PathVariable Long specId) {
        return specialityRepository.findById(specId).map(speciality -> {
            specialityRepository.delete(speciality);
            return ResponseEntity.ok().build();
        }).orElseThrow(() -> new ResourceNotFoundException("specId " + specId + " not found"));
    }
}
