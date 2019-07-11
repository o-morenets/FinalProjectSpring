package ua.training.admission.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import ua.training.admission.entity.User;
import ua.training.admission.repository.UserRepository;

import java.util.Optional;

@Controller
@RequestMapping("/users")
public class UserController {

    private final UserRepository userRepository;

    @Autowired
    public UserController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public String getAllUsers(Model model) {
        model.addAttribute("users", userRepository.findAll());

        return "user_list";
    }

    @GetMapping("{user}")
    public String userInfo(Model model, @PathVariable User user) {
        Optional<User> loginedUser = userRepository.findById(user.getId());
        loginedUser.ifPresent(value -> model.addAttribute("userInfo", value));

        return "user_info";
    }
}
