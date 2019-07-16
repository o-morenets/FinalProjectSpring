package ua.training.admission.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ua.training.admission.entity.User;
import ua.training.admission.service.SpecialityService;
import ua.training.admission.service.SubjectGradeService;
import ua.training.admission.service.UserService;

import java.util.Map;

@Slf4j
@Controller
@RequestMapping("users")
public class UserController {

    private final UserService userService;
    private final SpecialityService specialityService;
    private final SubjectGradeService subjectGradeService;

    @Autowired
    public UserController(UserService userService, SpecialityService specialityService, SubjectGradeService subjectGradeService) {
        this.userService = userService;
        this.specialityService = specialityService;
        this.subjectGradeService = subjectGradeService;
    }

    @GetMapping
    public String userList(Model model) {
        model.addAttribute("users", userService.findAll());

        return "userList";
    }

    @GetMapping("{user}")
    public String selectSpeciality(@PathVariable User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("specialities", specialityService.findAll());

        return "userSpeciality";
    }

    @PostMapping
    public String updateSpeciality(@RequestParam("userId") User user, @RequestParam Map<String, String> form) {
        userService.updateSpeciality(user, form);

        return "redirect:users/profile";
    }

    @GetMapping("profile")
    public String userProfile(@AuthenticationPrincipal User principal, Model model) {
        userService.getOne(principal.getId()).ifPresent(user -> model.addAttribute("usr", user));
        model.addAttribute("grades", subjectGradeService.getUserGrades(principal));

        return "userProfile";
    }
}
