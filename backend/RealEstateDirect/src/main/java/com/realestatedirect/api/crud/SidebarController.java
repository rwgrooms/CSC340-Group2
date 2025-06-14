package com.realestatedirect.api.crud;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class SidebarController {

    private final UserService userService;

    @Autowired
    private HttpServletRequest request;

    SidebarController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/sidebar/{id}")
    public String getSidebar(@PathVariable Long id, Model model) {
        User user = userService.getUserById(id).orElse(null);
        model.addAttribute("user", user);
        model.addAttribute("_csrf", request.getAttribute("_csrf"));

        return "sidebar"; // Will resolve to sidebar.ftlh
    }
    @GetMapping("/welcome")
    public String getWelcome() {
        return "welcome";
    }
    

}
