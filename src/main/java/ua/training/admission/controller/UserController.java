package ua.training.admission.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ua.training.admission.entity.*;
import ua.training.admission.entity.dto.UserSubjectGradeDto;
import ua.training.admission.service.SpecialityService;
import ua.training.admission.service.SubjectGradeService;
import ua.training.admission.service.SubjectService;
import ua.training.admission.service.UserService;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Controller
@RequestMapping("/users")
public class UserController {

    private final UserService userService;
    private final SpecialityService specialityService;
    private final SubjectGradeService subjectGradeService;
    private SubjectService subjectService;

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

    @GetMapping("/{user}/selectSpec")
    public String selectSpeciality(@PathVariable User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("specialities", specialityService.findAll());

        return "userSpeciality";
    }

    @PostMapping("/updateSpec")
    public String updateSpeciality(@RequestParam("userId") User user, @RequestParam("specRadios") Long value) {
        userService.updateSpeciality(user, value);

        return "redirect:/users/profile";
    }

    @GetMapping("/profile")
    public String userProfile(@AuthenticationPrincipal User principal, Model model) {
        final Optional<User> usr = userService.getOne(principal.getId());
        usr.ifPresent(u -> {
            model.addAttribute("usr", u);
            model.addAttribute("userSubjectGradeDtoList", getUserSubjectGradeDtoList(u));
        });

        return "userGrades";
    }

    private List<UserSubjectGradeDto> getUserSubjectGradeDtoList(User u) {
        final List<Subject> subjects = subjectService.findBySpeciality(u.getSpeciality());
        final List<SubjectGrade> subjectGrades = subjectGradeService.getUserGrades(u);

        return UserSubjectGradeDto.getUserSubjectGradeDtoList(subjects, subjectGrades);
    }

    @GetMapping("/{user}/grades")
    public String userGrades(@PathVariable User user, Model model) {
        final Optional<User> usr = userService.getOne(user.getId());
        usr.ifPresent(u -> {
            model.addAttribute("usr", u);
            model.addAttribute("userSubjectGradeDtoList", getUserSubjectGradeDtoList(u));
        });

        return "userGrades";
    }

    @PostMapping("/updateGrades")
    public String updateGrades(@RequestParam("userId") User user, @RequestParam Map<String, String> form) {
        userService.updateGrades(user, form);

        return "redirect:/users";
    }
}
