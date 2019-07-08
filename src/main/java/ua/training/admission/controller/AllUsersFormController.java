package ua.training.admission.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import ua.training.admission.dto.UsersDTO;
import ua.training.admission.service.UserService;

@Slf4j
@RestController
public class AllUsersFormController {

    private final UserService userService;

    @Autowired
    public AllUsersFormController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "/all_users", method = RequestMethod.GET)
    public UsersDTO getAllUsers() {
        UsersDTO allUsers = userService.getAllUsers();
        log.info("{}", allUsers);
        return allUsers;
    }

}
