package com.example.megaCity.Controller;


import com.example.megaCity.Model.Driver;
import com.example.megaCity.Model.DriverHistory;
import com.example.megaCity.Service.DriverHistoryService;
import com.example.megaCity.Service.DriverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/drivers")
public class DriverRestController {

    @Autowired
    private DriverService driverService;

    @Autowired
    private DriverHistoryService driverHistoryService;

    // Get all drivers
    @GetMapping
    public List<Driver> getAllDrivers() {
        return driverService.getAllDrivers();
    }

    // Get driver by ID
    @GetMapping("/{driverId}")
    public ResponseEntity<Driver> getDriverById(@PathVariable String driverId) {
        return driverService.getDriverById(driverId)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Add new driver
    @PostMapping
    public ResponseEntity<Driver> addDriver(@RequestBody Driver driver) {
        Driver savedDriver = driverService.saveDriver(driver);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedDriver);
    }

    // Update driver
    @PutMapping("/{driverId}")
    public ResponseEntity<Driver> updateDriver(@PathVariable String driverId, @RequestBody Driver driver) {
        if (!driverService.getDriverById(driverId).isPresent()) {
            return ResponseEntity.notFound().build();
        }
        driver.setDriverId(driverId);
        return ResponseEntity.ok(driverService.saveDriver(driver));
    }

    // Delete driver
    @DeleteMapping("/{driverId}")
    public ResponseEntity<Void> deleteDriver(@PathVariable String driverId) {
        if (!driverService.getDriverById(driverId).isPresent()) {
            return ResponseEntity.notFound().build();
        }
        driverService.deleteDriver(driverId);
        return ResponseEntity.noContent().build();
    }

    // Update driver availability
    @PatchMapping("/{driverId}/availability")
    public ResponseEntity<Driver> updateDriverAvailability(
            @PathVariable String driverId,
            @RequestBody Map<String, Object> payload) {
        boolean available = (boolean) payload.get("available");
        String bookingNo = (String) payload.get("bookingNo");

        Driver updatedDriver = driverService.updateDriverAvailability(driverId, available, bookingNo);
        if (updatedDriver == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(updatedDriver);
    }

    // Get available drivers
    @GetMapping("/available")
    public List<Driver> getAvailableDrivers() {
        return driverService.getAvailableDrivers();
    }

    // Get driver history
    @GetMapping("/{driverId}/history")
    public List<DriverHistory> getDriverHistory(@PathVariable String driverId) {
        return driverHistoryService.getDriverHistoryByDriverId(driverId);
    }

    // Add driver history record
    @PostMapping("/history")
    public ResponseEntity<DriverHistory> addDriverHistory(@RequestBody DriverHistory driverHistory) {
        DriverHistory savedHistory = driverHistoryService.saveDriverHistory(driverHistory);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedHistory);
    }

    // Calculate salary
    @GetMapping("/{driverId}/salary")
    public ResponseEntity<Map<String, Double>> calculateSalary(
            @PathVariable String driverId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        Double totalSalary = driverHistoryService.calculateTotalSalary(driverId, startDate, endDate);
        return ResponseEntity.ok(Map.of("totalSalary", totalSalary));
    }
}
