package com.example.megaCity.Service;

import com.example.megaCity.Model.Driver;
import com.example.megaCity.Repository.DriverRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DriverService {

    @Autowired
    private DriverRepository driverRepository;

    // Get all drivers
    public List<Driver> getAllDrivers() {
        return driverRepository.findAll();
    }

    // Get driver by ID
    public Optional<Driver> getDriverById(String driverId) {
        return driverRepository.findById(driverId);
    }

    // Save or update driver
    public Driver saveDriver(Driver driver) {
        // Generate driver ID if it's a new driver
        if (driver.getDriverId() == null || driver.getDriverId().isEmpty()) {
            driver.setDriverId(generateDriverId());
        }
        return driverRepository.save(driver);
    }

    // Delete driver
    public void deleteDriver(String driverId) {
        driverRepository.deleteById(driverId);
    }

    // Find available drivers
    public List<Driver> getAvailableDrivers() {
        return driverRepository.findByAvailableTrue();
    }

    // Update driver availability
    public Driver updateDriverAvailability(String driverId, boolean available, String bookingNo) {
        Optional<Driver> optionalDriver = driverRepository.findById(driverId);
        if (optionalDriver.isPresent()) {
            Driver driver = optionalDriver.get();
            driver.setAvailable(available);
            driver.setCurrentBookingNo(bookingNo);
            return driverRepository.save(driver);
        }
        return null;
    }

    // Search drivers by NIC or name
    public List<Driver> searchDrivers(String keyword) {
        List<Driver> resultsByNic = driverRepository.findByNicContaining(keyword);
        List<Driver> resultsByName = driverRepository.findByFirstNameContaining(keyword);

        // Combine results and remove duplicates
        resultsByNic.removeAll(resultsByName);
        resultsByNic.addAll(resultsByName);

        return resultsByNic;
    }

    // Generate a new driver ID
    private String generateDriverId() {
        // Simple ID generation: count + 1, formatted as 3 digits
        long count = driverRepository.count() + 1;
        return String.format("%03d", count);
    }
}
