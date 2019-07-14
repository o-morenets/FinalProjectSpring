package ua.training.admission.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ua.training.admission.entity.Speciality;
import ua.training.admission.repository.SpecialityRepository;

import java.util.List;

@Service
public class SpecialityService {

    private final SpecialityRepository specialityRepository;

    @Autowired
    public SpecialityService(SpecialityRepository specialityRepository) {
        this.specialityRepository = specialityRepository;
    }

    public List<Speciality> findAll() {
        return specialityRepository.findAll();
    }
}
