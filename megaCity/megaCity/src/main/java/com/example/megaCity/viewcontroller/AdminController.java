package com.example.megaCity.viewcontroller;

import com.example.megaCity.Model.User;
import com.example.megaCity.Service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
public class AdminController {

    private final UserService userService;

    @Autowired
    public AdminController(UserService userService) {
        this.userService = userService;
    }

    // Check if user is admin
    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return user != null && "ADMIN".equals(user.getUserType());
    }

    @GetMapping("/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        // Only allow admins to access the dashboard
        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        model.addAttribute("customers", userService.getAllCustomers());
        return "dashboard"; // Maps to dashboard.jsp
    }

    @GetMapping("/UserDetails")
    public String adminUsers(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        model.addAttribute("users", userService.getAllUsers());
        return "UserDetails";
    }
}