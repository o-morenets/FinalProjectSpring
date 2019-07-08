package ua.training.admission.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ua.training.admission.dto.UserSignupDTO;
import ua.training.admission.service.UserService;

@Slf4j
@RestController
@RequestMapping(value = "/api")
public class RegFormController {

    private final UserService userService;

    @Autowired
    public RegFormController(UserService userService) {
        this.userService = userService;
    }

//    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(value = "/reg_form", method = RequestMethod.POST)
    public String registrationFormController(UserSignupDTO userSignupDTO) {

        // TODO validate DTO -> return to frontEnd when error

        userService.saveNewUser(userSignupDTO);
        log.info("{}", userSignupDTO);

        return "redirect:/";
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity handleRuntimeException(RuntimeException ex) {
        return ResponseEntity.badRequest().body(ex);
    }
}
