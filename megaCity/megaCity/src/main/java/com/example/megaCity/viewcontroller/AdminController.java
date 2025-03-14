package com.example.megaCity.viewcontroller;

import com.example.megaCity.Model.User;
import com.example.megaCity.Service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("/admin")
public class AdminController {

    private final UserService userService;

    @Autowired
    public AdminController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getUserType())) {
            return "redirect:/login";
        }

        model.addAttribute("customers", userService.getAllCustomers());
        return "admin/dashboard";
    }

    @GetMapping("/users")
    public String adminUsers(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getUserType())) {
            return "redirect:/login";
        }

        model.addAttribute("users", userService.getAllUsers());
        return "admin/users";
    }
}