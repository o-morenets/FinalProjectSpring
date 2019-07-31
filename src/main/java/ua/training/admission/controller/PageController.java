package ua.training.admission.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
public class PageController {

    @RequestMapping("/")
    public String homePage() {
        return "homePage";
    }

    @RequestMapping(value = "/403")
    public String page403() {

        return "error/403";
    }
}
