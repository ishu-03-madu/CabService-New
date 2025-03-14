package com.example.megaCity.Repository;

import com.example.megaCity.Model.DriverHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface DriverHistoryRepository extends JpaRepository<DriverHistory, Long> {
    // Find by driver ID
    List<DriverHistory> findByDriverId(String driverId);

    // Find by NIC
    List<DriverHistory> findByNicContaining(String nic);

    // Find by date range
    List<DriverHistory> findByStartDateGreaterThanEqualAndEndDateLessThanEqual(LocalDate startDate, LocalDate endDate);

    // Calculate total salary for a driver within a date range
    @Query("SELECT SUM(dh.rideAmount) FROM DriverHistory dh WHERE dh.driverId = ?1 AND dh.startDate >= ?2 AND dh.endDate <= ?3")
    Double calculateTotalSalary(String driverId, LocalDate startDate, LocalDate endDate);
}
