package ua.training.admission.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import ua.training.admission.dto.UserSignupDto;
import ua.training.admission.service.UserService;

@Slf4j
@Controller
public class RegFormController {

    private final UserService userService;

    @Autowired
    public RegFormController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/signup")
    public String signUp() {
        return "signup";
    }

    @PostMapping("/signup")
    public String addUser(UserSignupDto userSignupDto, Model model) {

        String returnPage = "redirect:/login";
        boolean isFormValid = true;

        if (StringUtils.isEmpty(userSignupDto.getFirstName())) {
            model.addAttribute("firstNameError", "First Name cannot be empty");
            isFormValid = false;
        }

        if (StringUtils.isEmpty(userSignupDto.getLastName())) {
            model.addAttribute("lastNameError", "Last Name cannot be empty");
            isFormValid = false;
        }

        if (StringUtils.isEmpty(userSignupDto.getPassword2())) {
            model.addAttribute("password2Error", "Password confirmation cannot be empty");
            isFormValid = false;
        }

        if (userSignupDto.getPassword() != null && !userSignupDto.getPassword().equals(userSignupDto.getPassword2())) {
            model.addAttribute("passwordError", "Passwords are different!");
            isFormValid = false;
        }

        if (!isFormValid) {
            returnPage = "signup";
        }

        if (!userService.createUser(userSignupDto)) {
            model.addAttribute("emailError", "User exists!");
            returnPage = "signup";
        }

        return returnPage;
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity handleRuntimeException(RuntimeException ex) {
        return ResponseEntity.badRequest().body(ex);
    }
}
