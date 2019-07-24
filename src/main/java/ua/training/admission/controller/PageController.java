package ua.training.admission.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Slf4j
@Controller
public class PageController {

    @RequestMapping("/")
    public String homePage() {
        return "homePage";
    }

    @RequestMapping(value = "/403")
    public String accessDenied(Model model, Principal principal) {
        if (principal != null) {
            String message = "Hi " + principal.getName() + "<br> You do not have permission to access this page!";
            model.addAttribute("message", message);
        }
        return "403";
    }
}
