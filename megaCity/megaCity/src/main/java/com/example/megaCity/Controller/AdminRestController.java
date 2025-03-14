package com.example.megaCity.Controller;

import com.example.megaCity.Model.Car;
import com.example.megaCity.Model.User;
import com.example.megaCity.Repository.CarRepository;
import com.example.megaCity.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/admin")
public class AdminRestController {
    @Autowired private CarRepository carRepository;
    @Autowired private UserService userService;
    private final String UPLOAD_DIR = "./images";

    @GetMapping("/cars")
    public List<Car> getAllCars() {
        return carRepository.findAll();
    }

    @GetMapping("/cars/{carNo}")
    public ResponseEntity<Car> getCarByCarNo(@PathVariable String carNo) {
        return carRepository.findById(carNo)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping("/cars")
    public ResponseEntity<Car> addCar(@RequestBody Car car) {
        carRepository.save(car);
        return ResponseEntity.ok(car);
    }

    @PostMapping("/cars/{carNo}/image")
    public ResponseEntity<?> uploadCarImage(@PathVariable String carNo,
                                            @RequestParam("image") MultipartFile image) throws IOException {
        Optional<Car> optionalCar = carRepository.findById(carNo);
        if (optionalCar.isEmpty()) return ResponseEntity.notFound().build();

        Car car = optionalCar.get();

        if (image != null && !image.isEmpty()) {
            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (!Files.exists(uploadPath)) Files.createDirectories(uploadPath);

            String filename = System.currentTimeMillis() + "_" + image.getOriginalFilename().replaceAll("\\s+", "_");
            Files.copy(image.getInputStream(), uploadPath.resolve(filename));

            car.setImages(filename);
            carRepository.save(car);

            return ResponseEntity.ok(Map.of("message", "Image uploaded successfully"));
        }

        return ResponseEntity.badRequest().body("No image provided");
    }

    @PutMapping("/cars/{carNo}")
    public ResponseEntity<Car> updateCar(@PathVariable String carNo, @RequestBody Car car) {
        if (!carRepository.existsById(carNo)) {
            return ResponseEntity.notFound().build();
        }

        car.setCarNo(carNo); // Ensure ID matches path variable
        carRepository.save(car);
        return ResponseEntity.ok(car);
    }

    @DeleteMapping("/cars/{carNo}")
    public ResponseEntity<Void> deleteCar(@PathVariable String carNo) {
        if (!carRepository.existsById(carNo)) {
            return ResponseEntity.notFound().build();
        }carRepository.deleteById(carNo);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/users")
    public List<User> getAllUsers() { return userService.getAllUsers();}

    @GetMapping("/users/customers")
    public List<User> getAllCustomers() {return userService.getAllCustomers();}

    @GetMapping("/users/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Long id) {
        return userService.getUserById(id)
                .map(user -> ResponseEntity.ok(user))
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/users")
    public ResponseEntity<User> createUser(@RequestBody User user) {
        return ResponseEntity.status(HttpStatus.CREATED).body(userService.saveUser(user));
    }

    @PutMapping("/users/{id}")
    public ResponseEntity<User> updateUser(@PathVariable Long id, @RequestBody User user) {
        if (!userService.getUserById(id).isPresent()) {
            return ResponseEntity.notFound().build();
        }
        user.setId(id);
        return ResponseEntity.ok(userService.saveUser(user));
    }

    @DeleteMapping("/users/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        if (!userService.getUserById(id).isPresent()) {
            return ResponseEntity.notFound().build();
        }
        userService.deleteUser(id);
        return ResponseEntity.noContent().build();
    }

    // Dashboard Statistics
    @GetMapping("/dashboard")
    public Map<String, Object> getDashboardStats() {
        return Map.of(
                "totalCars", carRepository.count(),
                "totalCustomers", userService.getAllCustomers().size()
        );
    }
}