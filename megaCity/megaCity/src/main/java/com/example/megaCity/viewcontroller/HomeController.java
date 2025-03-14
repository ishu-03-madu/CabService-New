package com.example.megaCity.viewcontroller;

import com.example.megaCity.Model.Car;
import com.example.megaCity.Repository.CarRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Comparator;
import java.util.stream.Collectors;

@Controller
public class HomeController {

    @Autowired
    private CarRepository carRepository;

    @GetMapping("/")
    public String redirectToHome() {
        return "redirect:/home";
    }

    @GetMapping("/home")
    public String home(Model model) {
        // Fetch all cars from the repository
        List<Car> allCars = carRepository.findAll();

        // You could implement logic to determine "popular" cars here
        // For now, we're just sorting them by price (from lowest to highest)
        List<Car> popularCars = allCars.stream()
                .sorted(Comparator.comparing(Car::getPrice))
                .collect(Collectors.toList());

        // Add the cars to the model
        model.addAttribute("cars", popularCars);

        return "home";  // This refers to home.jsp
    }
}