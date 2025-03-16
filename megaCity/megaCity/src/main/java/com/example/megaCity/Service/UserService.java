package com.example.megaCity.Service;
import com.example.megaCity.Model.User;
import com.example.megaCity.Repository.UserRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @PostConstruct
    public void init() {
        // Check if admin exists - use the correct email "admin@gmail.com"
//        if (userRepository.findByEmail("admin@gmail.com").isEmpty()) {
//            // Create admin user
//            User admin = new User("Admin", "User", "ad@gmail.com", "admin123", "ADMIN");
//            userRepository.save(admin);
//        }
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public List<User> getAllCustomers() {
        return userRepository.findByUserType("CUSTOMER");
    }

    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }

    public Optional<User> getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public User saveUser(User user) {
        // Check if this is the admin user
        if ("admin@gmail.com".equals(user.getEmail())) {
            // Prevent admin modification
            return user;
        }
        return userRepository.save(user);
    }

    public void deleteUser(Long id) {
        Optional<User> user = userRepository.findById(id);
        // Prevent deletion of admin
        if (user.isPresent() && !"admin@gmail.com".equals(user.get().getEmail())) {
            userRepository.deleteById(id);
        }
    }

    public User authenticateUser(String email, String password) {
        // Special case for admin
        if ("admin@gmail.com".equals(email) && "admin123".equals(password)) {
            return userRepository.findByEmail("admin@gmail.com").orElse(null);
        }

        // Regular authentication
        Optional<User> userOpt = userRepository.findByEmail(email);
        if (userOpt.isPresent() && userOpt.get().getPassword().equals(password)) {
            return userOpt.get();
        }
        return null;
    }
}