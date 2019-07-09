package ua.training.admission.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ua.training.admission.entity.Speciality;
import ua.training.admission.exception.ResourceNotFoundException;
import ua.training.admission.repository.SpecialityRepository;

import javax.validation.Valid;

@RestController
@RequestMapping("/specialities")
public class SpecialityRestController {

    private final SpecialityRepository specialityRepository;

    @Autowired
    public SpecialityRestController(SpecialityRepository specialityRepository) {
        this.specialityRepository = specialityRepository;
    }

    @GetMapping("")
    public Page<Speciality> getAllSpecialities(Pageable pageable) {
        return specialityRepository.findAll(pageable);
    }

    @PostMapping(value = "",
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Speciality createSpeciality(@Valid @RequestBody Speciality speciality) {
        return specialityRepository.save(speciality);
    }

    @PutMapping("/{specialityId}")
    public Speciality updateSpeciality(@PathVariable Long specialityId, @Valid @RequestBody Speciality specialityRequest) {
        return specialityRepository.findById(specialityId).map(speciality -> {
            speciality.setName(specialityRequest.getName());
            return specialityRepository.save(speciality);
        }).orElseThrow(() -> new ResourceNotFoundException("SpecialityId " + specialityId + " not found"));
    }

    @DeleteMapping("/{specialityId}")
    public ResponseEntity<?> deleteSpeciality(@PathVariable Long specialityId) {
        return specialityRepository.findById(specialityId).map(speciality -> {
            specialityRepository.delete(speciality);
            return ResponseEntity.ok().build();
        }).orElseThrow(() -> new ResourceNotFoundException("SpecialityId " + specialityId + " not found"));
    }
}
