package com.example.megaCity.Controller;
import com.example.megaCity.Model.Driver;
import com.example.megaCity.Model.DriverHistory;
import com.example.megaCity.Service.DriverHistoryService;
import com.example.megaCity.Service.DriverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Controller
public class DriverAvailabilityController {

    @Autowired
    private DriverService driverService;

    @Autowired
    private DriverHistoryService driverHistoryService;

    // Driver Availability Page
    @GetMapping("/DriverAvailability")
    public String driverAvailabilityPage(Model model) {
        List<Driver> drivers = driverService.getAllDrivers();
        List<DriverHistory> driverHistories = driverHistoryService.getAllDriverHistory();

        model.addAttribute("drivers", drivers);
        model.addAttribute("driverHistories", driverHistories);
        return "DriverAvailability";
    }

    // Update driver availability
    @PostMapping("/drivers/availability/update")
    public String updateDriverAvailability(@RequestParam String driverId,
                                           @RequestParam boolean available,
                                           @RequestParam(required = false) String bookingNo) {
        driverService.updateDriverAvailability(driverId, available, bookingNo);
        return "redirect:/DriverAvailability";
    }

    // Mark ride as done
    @GetMapping("/drivers/ride/done/{driverId}")
    public String markRideAsDone(@PathVariable String driverId) {
        driverService.updateDriverAvailability(driverId, true, null);
        return "redirect:/DriverAvailability";
    }

    // Search driver history
    @GetMapping("/drivers/history/search")
    public String searchDriverHistory(@RequestParam String keyword, Model model) {
        List<Driver> drivers = driverService.getAllDrivers();
        List<DriverHistory> driverHistories = driverHistoryService.searchDriverHistoryByNic(keyword);

        model.addAttribute("drivers", drivers);
        model.addAttribute("driverHistories", driverHistories);
        model.addAttribute("searchKeyword", keyword);
        return "DriverAvailability";
    }

    // Calculate total salary
    @GetMapping("/drivers/salary/calculate")
    @ResponseBody
    public Double calculateSalary(@RequestParam String driverId,
                                  @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
                                  @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        return driverHistoryService.calculateTotalSalary(driverId, startDate, endDate);
    }
}
