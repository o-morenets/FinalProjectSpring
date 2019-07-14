package ua.training.admission.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ua.training.admission.entity.User;
import ua.training.admission.service.SpecialityService;
import ua.training.admission.service.UserService;

import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/users")
public class UserController {

    private final UserService userService;
    private final SpecialityService specialityService;

    @Autowired
    public UserController(UserService userService, SpecialityService specialityService) {
        this.userService = userService;
        this.specialityService = specialityService;
    }

    @GetMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public String userList(Model model) {
        model.addAttribute("users", userService.findAll());

        return "userList";
    }

    @GetMapping("{user}")
    public String userSpeciality(@PathVariable User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("specialities", specialityService.findAll());

        return "userSpeciality";
    }

    @PostMapping
    public String userSpeciality(@RequestParam("userId") User user, @RequestParam Map<String, String> form) {
        userService.updateSpeciality(user, form);

        return "redirect:/users";
    }

    @GetMapping("profile")
    public String userProfile(@AuthenticationPrincipal User user, Model model) {
        model.addAttribute("user", user);

        return "userProfile";
    }

    @PostMapping("profile")
    public String userProfile(
            @AuthenticationPrincipal User user,
            @RequestParam String email,
            @RequestParam String firstName,
            @RequestParam String lastName
    ) {
        userService.updateProfile(user, email, firstName, lastName);

        return "redirect:/users/profile";
    }
}
