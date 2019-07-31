package ua.training.admission.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ua.training.admission.entity.Role;
import ua.training.admission.entity.Subject;
import ua.training.admission.entity.SubjectGrade;
import ua.training.admission.entity.User;
import ua.training.admission.exception.ResourceNotFoundException;
import ua.training.admission.service.SpecialityService;
import ua.training.admission.service.SubjectGradeService;
import ua.training.admission.service.SubjectService;
import ua.training.admission.service.UserService;

import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/users")
public class UserController {

    private final UserService userService;
    private final SpecialityService specialityService;
    private final SubjectGradeService subjectGradeService;
    private final SubjectService subjectService;

    @Autowired
    public UserController(UserService userService,
                          SpecialityService specialityService,
                          SubjectGradeService subjectGradeService,
                          SubjectService subjectService
    ) {
        this.userService = userService;
        this.specialityService = specialityService;
        this.subjectGradeService = subjectGradeService;
        this.subjectService = subjectService;
    }

    @GetMapping
    public String userList(Model model) {
        model.addAttribute("users", userService.findAllByRole(Role.USER));

        return "userList";
    }

    @GetMapping("/{user}/speciality")
    public String selectSpeciality(@PathVariable User user, Model model) {
        User usr = userService.findById(user.getId()).orElseThrow(ResourceNotFoundException::new);

        model.addAttribute("user", usr);
        model.addAttribute("specialities", specialityService.findAll());

        return "userSpeciality";
    }

    @PostMapping("/updateSpec")
    public String updateSpeciality(@RequestParam("userId") User user, @RequestParam("specRadios") Long specId) {
        userService.updateSpeciality(user, specId);

        return "redirect:/users/" + user.getId() + "/grades";
    }

    @GetMapping("/profile")
    public String userProfile(@AuthenticationPrincipal User principal, Model model) {
        User usr = userService.findById(principal.getId()).orElseThrow(ResourceNotFoundException::new);
        addModelAttributes(model, usr);

        return "userGrades";
    }

    @GetMapping("/{userId}/grades")
    public String userGrades(@PathVariable Long userId, Model model) {
        User usr = userService.findById(userId).orElseThrow(ResourceNotFoundException::new);
        addModelAttributes(model, usr);

        return "userGrades";
    }

    private void addModelAttributes(Model model, User usr) {
        List<Subject> subjects = subjectService.findBySpeciality(usr.getSpeciality());
        List<SubjectGrade> subjectGrades = subjectGradeService.findUserGrades(usr);
        model.addAttribute("user", usr);
        model.addAttribute("userSubjectGradeDtoList",
                userService.getUserSubjectGradeDtoList(subjects, subjectGrades));
    }

    @PostMapping("/updateGrades")
    public String updateGrades(@RequestParam("userId") User user, @RequestParam Map<String, String> form) {
        subjectGradeService.updateGrades(user, form);

        return "redirect:/users";
    }

    @ResponseStatus(value = HttpStatus.NOT_FOUND, reason = "No such user in database")
    @ExceptionHandler(ResourceNotFoundException.class)
    public void resourceNotFound(ResourceNotFoundException e) {
        log.warn("No such user in database", e);
    }
}
