package com.realestatedirect.api.crud;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    @Autowired
    private UserService userService;

   @GetMapping("/dashboard")
    public String showDashboard(Model model, Principal principal) {
        User user = userService.getUserByEmail(principal.getName()).orElse(null);
        model.addAttribute("user", user);
        return "dashboard";
    }

    
}
