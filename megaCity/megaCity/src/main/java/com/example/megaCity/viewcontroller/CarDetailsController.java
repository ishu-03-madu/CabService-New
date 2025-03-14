package com.example.megaCity.viewcontroller;

import com.example.megaCity.Model.Car;
import com.example.megaCity.Repository.CarRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Controller
public class CarDetailsController {

    @Autowired
    private CarRepository carRepository;

    @GetMapping("/carDetails/{carNo}")
    public String carDetails(@PathVariable String carNo, Model model) {
        Optional<Car> optionalCar = carRepository.findById(carNo);

        if (!optionalCar.isPresent()) {
            return "redirect:/cars";  // Redirect to car listing if car not found
        }

        Car car = optionalCar.get();
        model.addAttribute("car", car);

        // Process included features (convert comma-separated string to list)
        if (car.getIncludedFeatures() != null && !car.getIncludedFeatures().isEmpty()) {
            List<String> includedFeaturesList = Arrays.asList(car.getIncludedFeatures().split(","));
            model.addAttribute("includedFeaturesList", includedFeaturesList);
        }

        // Process excluded features (convert comma-separated string to list)
        if (car.getExcludedFeatures() != null && !car.getExcludedFeatures().isEmpty()) {
            List<String> excludedFeaturesList = Arrays.asList(car.getExcludedFeatures().split(","));
            model.addAttribute("excludedFeaturesList", excludedFeaturesList);
        }

        return "carDetails";  // This maps to /WEB-INF/views/carDetails.jsp
    }

    // List all cars (for the main rental page)
    @GetMapping("/structuredpage")
    public String listCars(Model model) {
        model.addAttribute("cars", carRepository.findAll());
        return "carListing";
    }
}