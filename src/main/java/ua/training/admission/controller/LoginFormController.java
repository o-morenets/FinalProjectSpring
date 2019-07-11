package ua.training.admission.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ua.training.admission.dto.UserLoginDto;
import ua.training.admission.entity.User;
import ua.training.admission.service.UserService;

import java.util.Optional;

@Slf4j
@Controller
public class LoginFormController {

    @GetMapping("/login")
    public String login(@RequestParam(name = "error", required = false) String error,
                        @RequestParam(name = "logout", required = false) String logout,
                        Model model) {

        model.addAttribute("error", error != null);
        model.addAttribute("logout", logout != null);

        return "login";
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity handleRuntimeException(RuntimeException ex) {
        return ResponseEntity.badRequest().body(ex);
    }
}
