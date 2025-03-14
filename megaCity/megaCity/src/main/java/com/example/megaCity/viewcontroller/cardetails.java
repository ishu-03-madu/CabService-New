package com.example.megaCity.viewcontroller;


import com.example.megaCity.Repository.CarRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class cardetails {

    @Autowired
    private CarRepository carRepository;

    @GetMapping("/carDetails")
    public String carDetails(Model model) {
        model.addAttribute("cars", carRepository.findAll());
        return "carDetails"; // Maps to /WEB-INF/views/carDetails.jsp
    }
}
