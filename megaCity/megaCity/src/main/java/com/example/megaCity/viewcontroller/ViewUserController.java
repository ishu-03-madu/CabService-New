package com.example.megaCity.viewcontroller;

import com.example.megaCity.Model.User;
import com.example.megaCity.Service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class ViewUserController {

    private final UserService userService;

    @Autowired
    public ViewUserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/user/dashboard")
    public String userDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("user", user);
        return "dashboard";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        RedirectAttributes redirectAttributes) {

        User user = userService.authenticateUser(email, password);

        if (user != null) {
            // Store user object in session
            session.setAttribute("user", user);

            if ("ADMIN".equals(user.getUserType())) {
                return "redirect:/admin/dashboard";
            } else {
                return "redirect:/home"; // Redirect to home page after login
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid email or password");
            return "redirect:/login";
        }
    }

    @GetMapping("/signup")
    public String registerPage(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute User user, RedirectAttributes redirectAttributes, HttpSession session) {
        // Set as customer by default for registration
        user.setUserType("CUSTOMER");

        // Check if email already exists
        if (userService.getUserByEmail(user.getEmail()).isPresent()) {
            redirectAttributes.addFlashAttribute("error", "Email already registered");
            return "redirect:/signup";
        }

        // Prevent registration with admin email
        if ("admin".equals(user.getEmail())) {
            redirectAttributes.addFlashAttribute("error", "This email is reserved");
            return "redirect:/signup";
        }

        User savedUser = userService.saveUser(user);

        // Log in the user automatically after registration
        session.setAttribute("user", savedUser);

        redirectAttributes.addFlashAttribute("success", "Registration successful!");
        return "redirect:/home";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // Invalidate the session to log out
        session.invalidate();
        return "redirect:/home";
    }

    @GetMapping("/profile")
    public String viewProfile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("user", user);
        return "profile";
    }
}