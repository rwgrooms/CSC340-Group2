package com.realestatedirect.api.crud;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

@Controller
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/register/registeruser")
    public Object ShowNewRegistration() {
        return "user-register";
    }

    @PostMapping("/register/createuser")
    public String createUser(User user, Model model) {
        User existingUser = userService.getUserByEmail(user.getEmail()).orElse(null);
        if (existingUser != null){
            model.addAttribute("title", "Email Already Exists");    
            model.addAttribute("user", existingUser);
        } else {
            User currentuser = userService.saveUser(user);
            model.addAttribute("user", currentuser);
        }
        //return "login"; change to login once security is implemented
        return "dashboard";
    }

    @GetMapping("/register/edituser/{id}")
    public Object ShowEditRegistration(@PathVariable Long id, Model model) {
        User currentuser = userService.getUserById(id).orElse(null);
        model.addAttribute("user", currentuser);
        return "edit-profile";
    }

    @PostMapping("/register/updateuser")
    public Object updateUser(User user, Model model) {
        User currentuser = userService.updateUser(user.getUserId(), user);
        model.addAttribute("user", currentuser);
        return "welcome";
    }

    @GetMapping("/register/deleteuser/{id}")
    public Object deleteUser(@PathVariable Long id) {
        userService.deleteUser(id);
        return "welcome";
    }
}
