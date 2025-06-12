package com.realestatedirect.api.crud;

//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

//import java.util.List;
//import java.util.Optional;

@Controller
public class SidebarController {

    private final UserService userService;

    SidebarController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/sidebar/{id}")
    public String getSidebar(@PathVariable Long id, Model model) {
        User user = userService.getUserById(id).orElse(null);
        model.addAttribute("user", user);
        return "sidebar"; // Will resolve to sidebar.ftlh
    }
    @GetMapping("/welcome")
    public String getWelcome() {
        return "welcome";
    }
    

}
