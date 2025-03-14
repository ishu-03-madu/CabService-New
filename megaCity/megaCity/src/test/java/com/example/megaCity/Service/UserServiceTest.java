package com.example.megaCity.Service;

import com.example.megaCity.Model.User;
import com.example.megaCity.Repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private UserService userService;

    private User adminUser;
    private User regularUser;

    @BeforeEach
    void setUp() {
        // Create test users
        adminUser = new User("Admin", "User", "admin@gmail.com", "admin123", "ADMIN");
        adminUser.setId(1L);

        regularUser = new User("Regular", "User", "regular@example.com", "password123", "CUSTOMER");
        regularUser.setId(2L);
    }

    @Test
    void init_WhenAdminDoesNotExist_ShouldCreateAdmin() {
        // Arrange
        when(userRepository.findByEmail("admin")).thenReturn(Optional.empty());
        when(userRepository.save(any(User.class))).thenReturn(adminUser);

        // Act
        userService.init();

        // Assert
        verify(userRepository, times(1)).findByEmail("admin");
        verify(userRepository, times(1)).save(any(User.class));
    }

    @Test
    void init_WhenAdminExists_ShouldNotCreateAdmin() {
        // Arrange
        when(userRepository.findByEmail("admin")).thenReturn(Optional.of(adminUser));

        // Act
        userService.init();

        // Assert
        verify(userRepository, times(1)).findByEmail("admin");
        verify(userRepository, never()).save(any(User.class));
    }

    @Test
    void getAllUsers_ShouldReturnAllUsers() {
        // Arrange
        List<User> userList = Arrays.asList(adminUser, regularUser);
        when(userRepository.findAll()).thenReturn(userList);

        // Act
        List<User> result = userService.getAllUsers();

        // Assert
        assertEquals(2, result.size());
        assertTrue(result.contains(adminUser));
        assertTrue(result.contains(regularUser));
        verify(userRepository, times(1)).findAll();
    }

    @Test
    void getAllCustomers_ShouldReturnOnlyCustomers() {
        // Arrange
        List<User> customerList = Arrays.asList(regularUser);
        when(userRepository.findByUserType("CUSTOMER")).thenReturn(customerList);

        // Act
        List<User> result = userService.getAllCustomers();

        // Assert
        assertEquals(1, result.size());
        assertTrue(result.contains(regularUser));
        assertFalse(result.contains(adminUser));
        verify(userRepository, times(1)).findByUserType("CUSTOMER");
    }

    @Test
    void getUserById_WhenUserExists_ShouldReturnUser() {
        // Arrange
        when(userRepository.findById(2L)).thenReturn(Optional.of(regularUser));

        // Act
        Optional<User> result = userService.getUserById(2L);

        // Assert
        assertTrue(result.isPresent());
        assertEquals(regularUser, result.get());
        verify(userRepository, times(1)).findById(2L);
    }

    @Test
    void getUserById_WhenUserDoesNotExist_ShouldReturnEmpty() {
        // Arrange
        when(userRepository.findById(3L)).thenReturn(Optional.empty());

        // Act
        Optional<User> result = userService.getUserById(3L);

        // Assert
        assertFalse(result.isPresent());
        verify(userRepository, times(1)).findById(3L);
    }

    @Test
    void getUserByEmail_WhenUserExists_ShouldReturnUser() {
        // Arrange
        when(userRepository.findByEmail("regular@example.com")).thenReturn(Optional.of(regularUser));

        // Act
        Optional<User> result = userService.getUserByEmail("regular@example.com");

        // Assert
        assertTrue(result.isPresent());
        assertEquals(regularUser, result.get());
        verify(userRepository, times(1)).findByEmail("regular@example.com");
    }

    @Test
    void saveUser_WhenRegularUser_ShouldSaveAndReturnUser() {
        // Arrange
        User newUser = new User("New", "User", "new@example.com", "password", "CUSTOMER");
        when(userRepository.save(any(User.class))).thenReturn(newUser);

        // Act
        User result = userService.saveUser(newUser);

        // Assert
        assertEquals(newUser, result);
        verify(userRepository, times(1)).save(newUser);
    }

    @Test
    void saveUser_WhenAdminUser_ShouldNotSaveAndReturnOriginal() {
        // Arrange
        User adminToSave = new User("Admin", "Changed", "admin", "changedpassword", "ADMIN");

        // Act
        User result = userService.saveUser(adminToSave);

        // Assert
        assertEquals(adminToSave, result);
        verify(userRepository, never()).save(any(User.class));
    }

    @Test
    void deleteUser_WhenRegularUser_ShouldDelete() {
        // Arrange
        when(userRepository.findById(2L)).thenReturn(Optional.of(regularUser));
        doNothing().when(userRepository).deleteById(2L);

        // Act
        userService.deleteUser(2L);

        // Assert
        verify(userRepository, times(1)).findById(2L);
        verify(userRepository, times(1)).deleteById(2L);
    }

    @Test
    void deleteUser_WhenAdminUser_ShouldNotDelete() {
        // Arrange
        when(userRepository.findById(1L)).thenReturn(Optional.of(adminUser));

        // Act
        userService.deleteUser(1L);

        // Assert
        verify(userRepository, times(1)).findById(1L);
        verify(userRepository, never()).deleteById(anyLong());
    }

    @Test
    void authenticateUser_WithCorrectCredentials_ShouldReturnUser() {
        // Arrange
        when(userRepository.findByEmail("regular@example.com")).thenReturn(Optional.of(regularUser));

        // Act
        User result = userService.authenticateUser("regular@example.com", "password123");

        // Assert
        assertNotNull(result);
        assertEquals(regularUser, result);
        verify(userRepository, times(1)).findByEmail("regular@example.com");
    }

    @Test
    void authenticateUser_WithIncorrectPassword_ShouldReturnNull() {
        // Arrange
        when(userRepository.findByEmail("regular@example.com")).thenReturn(Optional.of(regularUser));

        // Act
        User result = userService.authenticateUser("regular@example.com", "wrongpassword");

        // Assert
        assertNull(result);
        verify(userRepository, times(1)).findByEmail("regular@example.com");
    }

    @Test
    void authenticateUser_WithNonexistentEmail_ShouldReturnNull() {
        // Arrange
        when(userRepository.findByEmail("nonexistent@example.com")).thenReturn(Optional.empty());

        // Act
        User result = userService.authenticateUser("nonexistent@example.com", "password123");

        // Assert
        assertNull(result);
        verify(userRepository, times(1)).findByEmail("nonexistent@example.com");
    }

    @Test
    void authenticateUser_WithAdminCredentials_ShouldReturnAdminUser() {
        // Arrange
        when(userRepository.findByEmail("admin")).thenReturn(Optional.of(adminUser));

        // Act
        User result = userService.authenticateUser("admin", "admin123");

        // Assert
        assertNotNull(result);
        assertEquals(adminUser, result);
        verify(userRepository, times(1)).findByEmail("admin");
    }
}