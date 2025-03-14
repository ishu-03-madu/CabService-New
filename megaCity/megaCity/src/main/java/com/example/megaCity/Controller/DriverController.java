package com.example.megaCity.Controller;

import com.example.megaCity.Model.Driver;
import com.example.megaCity.Service.DriverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class DriverController {

    @Autowired
    private DriverService driverService;

    // Driver Details Page
    @GetMapping("/DriverDetails")
    public String driverDetailsPage(Model model) {
        List<Driver> drivers = driverService.getAllDrivers();
        model.addAttribute("drivers", drivers);
        model.addAttribute("driver", new Driver()); // For the form
        return "DriverDetails";
    }

    // Add new driver
    @PostMapping("/drivers/add")
    public String addDriver(@ModelAttribute Driver driver) {
        driverService.saveDriver(driver);
        return "redirect:/DriverDetails";
    }

    // Delete driver
    @GetMapping("/drivers/delete/{driverId}")
    public String deleteDriver(@PathVariable String driverId) {
        driverService.deleteDriver(driverId);
        return "redirect:/DriverDetails";
    }

    // Get driver for update
    @GetMapping("/drivers/edit/{driverId}")
    @ResponseBody
    public Driver getDriverForEdit(@PathVariable String driverId) {
        return driverService.getDriverById(driverId).orElse(new Driver());
    }

    // Update driver
    @PostMapping("/drivers/update")
    public String updateDriver(@ModelAttribute Driver driver) {
        driverService.saveDriver(driver);
        return "redirect:/DriverDetails";
    }
}