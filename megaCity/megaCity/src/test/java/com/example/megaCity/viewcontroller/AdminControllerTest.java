package com.example.megaCity.viewcontroller;

import com.example.megaCity.Model.User;
import com.example.megaCity.Service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.ui.Model;
import org.springframework.mock.web.MockHttpSession;

import java.util.ArrayList;
import java.util.List;

// Remove the jdk.internal import and use these instead
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

class AdminControllerTest {

    @Mock
    private UserService userService;

    @Mock
    private Model model;

    @InjectMocks
    private AdminController adminController;

    private MockHttpSession session;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
        session = new MockHttpSession();
    }

    @Test
    public void testAdminDashboard_WithAdminUser_ShouldReturnDashboardView() {
        // Arrange
        User adminUser = new User();
        adminUser.setUserType("ADMIN");

        session.setAttribute("user", adminUser);

        List<User> customers = new ArrayList<>();
        when(userService.getAllCustomers()).thenReturn(customers);

        // Act
        String viewName = adminController.adminDashboard(session, model);

        // Assert
        assertEquals("admin/dashboard", viewName);
        verify(model, times(1)).addAttribute("customers", customers);
        verify(userService, times(1)).getAllCustomers();
    }

    @Test
    public void testAdminDashboard_WithNonAdminUser_ShouldRedirectToLogin() {
        // Arrange
        User regularUser = new User();
        regularUser.setUserType("CUSTOMER");

        session.setAttribute("user", regularUser);

        // Act
        String viewName = adminController.adminDashboard(session, model);

        // Assert
        assertEquals("redirect:/login", viewName);
        verify(model, never()).addAttribute(anyString(), any());
        verify(userService, never()).getAllCustomers();
    }

    @Test
    public void testAdminDashboard_WithNoUser_ShouldRedirectToLogin() {
        // No user in session

        // Act
        String viewName = adminController.adminDashboard(session, model);

        // Assert
        assertEquals("redirect:/login", viewName);
        verify(model, never()).addAttribute(anyString(), any());
        verify(userService, never()).getAllCustomers();
    }
}