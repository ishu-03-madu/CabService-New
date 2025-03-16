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
    public ResponseEntity<List<Driver>> getAllDrivers() {
        List<Driver> drivers = driverService.getAllDrivers();
        return ResponseEntity.ok(drivers);
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
        try {
            Driver savedDriver = driverService.saveDriver(driver);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedDriver);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
    }

    // Update driver
    @PutMapping("/{driverId}")
    public ResponseEntity<Driver> updateDriver(@PathVariable String driverId, @RequestBody Driver driver) {
        if (!driverService.getDriverById(driverId).isPresent()) {
            return ResponseEntity.notFound().build();
        }
        driver.setDriverId(driverId);
        try {
            Driver updatedDriver = driverService.saveDriver(driver);
            return ResponseEntity.ok(updatedDriver);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
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
        try {
            boolean available = (boolean) payload.get("available");
            String bookingNo = (String) payload.get("bookingNo");

            Driver updatedDriver = driverService.updateDriverAvailability(driverId, available, bookingNo);
            if (updatedDriver == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(updatedDriver);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
    }

    // Get available drivers
    @GetMapping("/available")
    public ResponseEntity<List<Driver>> getAvailableDrivers() {
        List<Driver> availableDrivers = driverService.getAvailableDrivers();
        return ResponseEntity.ok(availableDrivers);
    }

    // Get driver history
    @GetMapping("/{driverId}/history")
    public ResponseEntity<List<DriverHistory>> getDriverHistory(@PathVariable String driverId) {
        List<DriverHistory> history = driverHistoryService.getDriverHistoryByDriverId(driverId);
        return ResponseEntity.ok(history);
    }

    // Add driver history record
    @PostMapping("/history")
    public ResponseEntity<DriverHistory> addDriverHistory(@RequestBody DriverHistory driverHistory) {
        try {
            DriverHistory savedHistory = driverHistoryService.saveDriverHistory(driverHistory);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedHistory);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
    }

    // Calculate salary (adjusted to return plain text)
    @GetMapping("/{driverId}/salary")
    public ResponseEntity<String> calculateSalary(
            @PathVariable String driverId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        try {
            Double totalSalary = driverHistoryService.calculateTotalSalary(driverId, startDate, endDate);
            if (totalSalary == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("0.00");
            }
            return ResponseEntity.ok(String.format("%.2f", totalSalary));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error calculating salary");
        }
    }
}