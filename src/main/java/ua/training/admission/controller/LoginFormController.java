package ua.training.admission.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ua.training.admission.dto.UserLoginDTO;
import ua.training.admission.entity.User;
import ua.training.admission.service.UserService;

import java.util.Optional;

@Slf4j
@RestController
@RequestMapping(value = "/")
public class LoginFormController {

    private final UserService userService;

    @Autowired
    public LoginFormController(UserService userService) {
        this.userService = userService;
    }

    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public void loginFormController(UserLoginDTO userLoginDTO) {
        log.info("{}", userLoginDTO);

        // TODO validate DTO -> return to frontEnd when error

        Optional<User> user = userService.login(userLoginDTO);
        log.info("{}", "Logined user: " + user);
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity handleRuntimeException(RuntimeException ex) {
        return ResponseEntity.badRequest().body(ex);
    }
}
