package ua.training.admission.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ua.training.admission.entity.Speciality;
import ua.training.admission.entity.Subject;
import ua.training.admission.repository.SpecialityRepository;
import ua.training.admission.repository.SubjectRepository;

import java.util.Collections;
import java.util.List;

@Service
public class SubjectService {

    private final SubjectRepository subjectRepository;

    @Autowired
    public SubjectService(SubjectRepository subjectRepository) {
        this.subjectRepository = subjectRepository;
    }

    public List<Subject> findBySpeciality(Speciality speciality) {
        return subjectRepository.findBySpecialities(Collections.singleton(speciality));
    }
}
