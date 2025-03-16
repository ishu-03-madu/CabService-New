package com.example.megaCity.Repository;

import com.example.megaCity.Model.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {

    // Find booking by bookingNo
    Optional<Booking> findByBookingNo(String bookingNo);

    // Find all bookings for a user
    List<Booking> findByUserId(Long userId);

    // Find bookings by customer NIC/Passport
    List<Booking> findByCustomerNic(String customerNic);

    // Find all bookings for a car
    List<Booking> findByCarNo(String carNo);

    // Find all bookings for a specific car within a date range
    @Query("SELECT b FROM Booking b WHERE b.carNo = ?1 AND b.status NOT IN ('CANCELLED') " +
            "AND ((b.startDate BETWEEN ?2 AND ?3) OR (b.endDate BETWEEN ?2 AND ?3) " +
            "OR (b.startDate <= ?2 AND b.endDate >= ?3))")
    List<Booking> findConflictingBookings(String carNo, LocalDate startDate, LocalDate endDate);

    // Find all bookings assigned to a driver
    List<Booking> findByDriverId(String driverId);

    // Find all bookings by status
    List<Booking> findByStatus(String status);

    // Advanced search by booking number or customer NIC containing the search term
    @Query("SELECT b FROM Booking b WHERE b.bookingNo LIKE %?1% OR b.customerNic LIKE %?1%")
    List<Booking> searchBookings(String searchTerm);
}