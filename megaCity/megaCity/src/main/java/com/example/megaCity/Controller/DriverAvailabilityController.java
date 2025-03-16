package com.example.megaCity.Controller;

import com.example.megaCity.Model.Driver;
import com.example.megaCity.Model.DriverHistory;
import com.example.megaCity.Service.DriverHistoryService;
import com.example.megaCity.Service.DriverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
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
    public String updateAvailability(@RequestParam String driverId, @RequestParam boolean available,
                                     @RequestParam(required = false) String bookingNo) {
        driverService.updateDriverAvailability(driverId, available, available ? null : bookingNo);
        return "redirect:/DriverAvailability";
    }

    // Mark ride as done and update history
    @GetMapping("/drivers/ride/done/{driverId}")
    public String markRideDone(@PathVariable String driverId) {
        Driver driver = driverService.getDriverById(driverId).orElse(null);
        if (driver != null && !driver.isAvailable()) {
            DriverHistory history = new DriverHistory();
            history.setDriverId(driver.getDriverId());
            history.setNic(driver.getNic());
            history.setFirstName(driver.getFirstName());
            history.setBookingId(driver.getCurrentBookingNo());
            // Convert LocalDate to Date
            history.setStartDate(Date.from(LocalDate.now().minusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant()));
            history.setEndDate(Date.from(LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant()));
            history.setRideAmount(500.0); // Example amount, adjust logic as needed
            driverHistoryService.saveDriverHistory(history);

            driverService.updateDriverAvailability(driverId, true, null);
        }
        return "redirect:/DriverAvailability";
    }

    // Search driver history
    @GetMapping("/drivers/history/search")
    public String searchDriverHistory(@RequestParam String keyword, Model model) {
        List<DriverHistory> driverHistories = driverHistoryService.searchDriverHistoryByNic(keyword);
        model.addAttribute("drivers", driverService.getAllDrivers());
        model.addAttribute("driverHistories", driverHistories);
        model.addAttribute("searchKeyword", keyword);
        return "DriverAvailability";
    }
}