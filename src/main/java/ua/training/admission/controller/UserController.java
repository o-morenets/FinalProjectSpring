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
    public String userInfo(@PathVariable User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("specialities", specialityService.findAll());

        return "userEdit";
    }

    @PostMapping
    public String userSave(
            @RequestParam Map<String, String> form,
            @RequestParam("userId") User user
    ) {
        userService.saveUser(user, form);

        return "redirect:/users";
    }

    // FIXME - profile does not work!!!
    @GetMapping("profile")
    public String userProfile(Model model, @AuthenticationPrincipal User user) {
        log.info("{}", user);
        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());

        return "profile";
    }

    @PostMapping("profile")
    public String updateProfile(
            @AuthenticationPrincipal User user,
            @RequestParam String email,
            @RequestParam String firstName,
            @RequestParam String lastName
    ) {
        userService.updateProfile(user, email, firstName, lastName);

        return "redirect:/users/profile";
    }
}
