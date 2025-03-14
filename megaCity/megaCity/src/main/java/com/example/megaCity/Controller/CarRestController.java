package com.example.megaCity.Controller;

import com.example.megaCity.Model.Car;
import com.example.megaCity.Repository.CarRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/cars")
public class CarRestController {

    @Autowired
    private CarRepository carRepository;

    // Define the image upload directory
    private final String UPLOAD_DIR = "./images";

    // Get all cars
    @GetMapping
    public List<Car> getAllCars() {
        return carRepository.findAll();
    }

    // Add a new car
    @PostMapping
    public ResponseEntity<Car> addCar(
            @RequestParam("carNo") String carNo,
            @RequestParam("name") String name,
            @RequestParam("type") String type,
            @RequestParam("brand") String brand,
            @RequestParam("price") double price,
            @RequestParam("peopleCapacity") int peopleCapacity,
            @RequestParam("doors") int doors,
            @RequestParam("fuelLiters") int fuelLiters,
            @RequestParam("aboutCar") String aboutCar,
            @RequestParam("includedFeatures") String includedFeatures,
            @RequestParam("excludedFeatures") String excludedFeatures,
            @RequestParam(value = "image", required = false) MultipartFile image) throws IOException {

        Car car = new Car();
        car.setCarNo(carNo);
        car.setName(name);
        car.setType(type);
        car.setBrand(brand);
        car.setPrice(price);
        car.setPeopleCapacity(peopleCapacity);
        car.setDoors(doors);
        car.setFuelLiters(fuelLiters);
        car.setAboutCar(aboutCar);
        car.setIncludedFeatures(includedFeatures);
        car.setExcludedFeatures(excludedFeatures);

        // Handle image upload
        if (image != null && !image.isEmpty()) {
            // Create directory if it doesn't exist
            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Save the file with a unique name
            String filename = System.currentTimeMillis() + "_" + image.getOriginalFilename().replaceAll("\\s+", "_");
            Path filePath = uploadPath.resolve(filename);
            Files.copy(image.getInputStream(), filePath);

            car.setImages(filename);
        }

        carRepository.save(car);
        return ResponseEntity.ok(car);
    }

    // Update an existing car
    @PutMapping("/{carNo}")
    public ResponseEntity<Car> updateCar(
            @PathVariable String carNo,
            @RequestParam("name") String name,
            @RequestParam("type") String type,
            @RequestParam("brand") String brand,
            @RequestParam("price") double price,
            @RequestParam("peopleCapacity") int peopleCapacity,
            @RequestParam("doors") int doors,
            @RequestParam("fuelLiters") int fuelLiters,
            @RequestParam("aboutCar") String aboutCar,
            @RequestParam("includedFeatures") String includedFeatures,
            @RequestParam("excludedFeatures") String excludedFeatures,
            @RequestParam(value = "image", required = false) MultipartFile image) throws IOException {

        Optional<Car> optionalCar = carRepository.findById(carNo);
        if (!optionalCar.isPresent()) {
            return ResponseEntity.notFound().build();
        }

        Car car = optionalCar.get();
        car.setName(name);
        car.setType(type);
        car.setBrand(brand);
        car.setPrice(price);
        car.setPeopleCapacity(peopleCapacity);
        car.setDoors(doors);
        car.setFuelLiters(fuelLiters);
        car.setAboutCar(aboutCar);
        car.setIncludedFeatures(includedFeatures);
        car.setExcludedFeatures(excludedFeatures);

        // Handle image upload - only update if a new image is provided
        if (image != null && !image.isEmpty()) {
            // Create directory if it doesn't exist
            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Save the file with a unique name
            String filename = System.currentTimeMillis() + "_" + image.getOriginalFilename().replaceAll("\\s+", "_");
            Path filePath = uploadPath.resolve(filename);
            Files.copy(image.getInputStream(), filePath);

            car.setImages(filename);
        }

        carRepository.save(car);
        return ResponseEntity.ok(car);
    }

    // Delete a car
    @DeleteMapping("/{carNo}")
    public ResponseEntity<Void> deleteCar(@PathVariable String carNo) {
        if (!carRepository.existsById(carNo)) {
            return ResponseEntity.notFound().build();
        }
        carRepository.deleteById(carNo);
        return ResponseEntity.ok().build();
    }


    @GetMapping("/{carNo}")
    public ResponseEntity<Car> getCarByCarNo(@PathVariable String carNo) {
        Optional<Car> car = carRepository.findById(carNo);
        return car.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }
}