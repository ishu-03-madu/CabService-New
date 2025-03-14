package com.example.megaCity.Service;


import com.example.megaCity.Model.DriverHistory;
import com.example.megaCity.Repository.DriverHistoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class DriverHistoryService {

    @Autowired
    private DriverHistoryRepository driverHistoryRepository;

    // Get all driver history records
    public List<DriverHistory> getAllDriverHistory() {
        return driverHistoryRepository.findAll();
    }

    // Get driver history by ID
    public Optional<DriverHistory> getDriverHistoryById(Long id) {
        return driverHistoryRepository.findById(id);
    }

    // Get driver history by driver ID
    public List<DriverHistory> getDriverHistoryByDriverId(String driverId) {
        return driverHistoryRepository.findByDriverId(driverId);
    }

    // Save driver history
    public DriverHistory saveDriverHistory(DriverHistory driverHistory) {
        return driverHistoryRepository.save(driverHistory);
    }

    // Delete driver history
    public void deleteDriverHistory(Long id) {
        driverHistoryRepository.deleteById(id);
    }

    // Search driver history by NIC
    public List<DriverHistory> searchDriverHistoryByNic(String nic) {
        return driverHistoryRepository.findByNicContaining(nic);
    }

    // Get driver history by date range
    public List<DriverHistory> getDriverHistoryByDateRange(LocalDate startDate, LocalDate endDate) {
        return driverHistoryRepository.findByStartDateGreaterThanEqualAndEndDateLessThanEqual(startDate, endDate);
    }

    // Calculate total salary for a driver within a date range
    public Double calculateTotalSalary(String driverId, LocalDate startDate, LocalDate endDate) {
        Double totalSalary = driverHistoryRepository.calculateTotalSalary(driverId, startDate, endDate);
        return totalSalary != null ? totalSalary : 0.0;
    }
}
