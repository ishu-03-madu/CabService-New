package com.example.megaCity.Controller;

import com.example.megaCity.Model.Booking;
import com.example.megaCity.Repository.BookingRepository;
import com.example.megaCity.Service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/bookings")
public class BookingRestController {

    @Autowired
    private BookingService bookingService;

    @Autowired
    private BookingRepository bookingRepository;

    // Get all bookings by status
    @GetMapping
    public ResponseEntity<List<Booking>> getBookings(@RequestParam(required = false) String status) {
        if (status != null && !status.isEmpty()) {
            return ResponseEntity.ok(bookingService.getBookingsByStatus(status));
        }
        // Default: return all bookings by status PENDING
        return ResponseEntity.ok(bookingService.getBookingsByStatus("PENDING"));
    }

    // Get booking by number
    @GetMapping("/{bookingNo}")
    public ResponseEntity<Booking> getBookingByNumber(@PathVariable String bookingNo) {
        return bookingService.getBookingByNumber(bookingNo)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Search bookings by booking number or customer NIC
    @GetMapping("/search")
    public ResponseEntity<List<Booking>> searchBookings(@RequestParam String query) {
        List<Booking> bookings = bookingRepository.searchBookings(query);
        return ResponseEntity.ok(bookings);
    }

    // Create new booking
    @PostMapping
    public ResponseEntity<Booking> createBooking(
            @RequestParam String carNo,
            @RequestParam Long userId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(required = false, defaultValue = "false") boolean withDriver,
            @RequestParam(required = false) String message) {

        try {
            Booking booking = bookingService.createBooking(carNo, userId, startDate, endDate, withDriver, message);
            return ResponseEntity.status(HttpStatus.CREATED).body(booking);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    // Update booking details (for admin form)
    @PutMapping("/{bookingNo}")
    public ResponseEntity<?> updateBooking(
            @PathVariable String bookingNo,
            @RequestParam(required = false) String carNo,
            @RequestParam(required = false) String customerNic,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(required = false) String destination,
            @RequestParam(required = false) Double startKm,
            @RequestParam(required = false) Double endKm,
            @RequestParam(required = false) Boolean withDriver,
            @RequestParam(required = false) Double driverCost,
            @RequestParam(required = false) Double paidAmount,
            @RequestParam(required = false) String paymentStatus,
            @RequestParam(required = false) Double extraCharges,
            @RequestParam(required = false) String extraChargesStatus,
            @RequestParam(required = false) Double refundableAmount,
            @RequestParam(required = false) String refundableStatus) {

        try {
            Optional<Booking> existingBookingOpt = bookingService.getBookingByNumber(bookingNo);
            if (!existingBookingOpt.isPresent()) {
                return ResponseEntity.notFound().build();
            }

            Booking existingBooking = existingBookingOpt.get();

            // Update booking with the provided fields
            if (carNo != null) existingBooking.setCarNo(carNo);
            if (customerNic != null) existingBooking.setCustomerNic(customerNic);
            if (startDate != null) existingBooking.setStartDate(startDate);
            if (endDate != null) existingBooking.setEndDate(endDate);
            if (destination != null) existingBooking.setDestination(destination);
            if (startKm != null) existingBooking.setStartKm(startKm);
            if (endKm != null) existingBooking.setEndKm(endKm);
            if (withDriver != null) existingBooking.setWithDriver(withDriver);
            if (driverCost != null) existingBooking.setDriverCost(driverCost);
            if (paidAmount != null) existingBooking.setPaidAmount(paidAmount);
            if (paymentStatus != null) existingBooking.setPaymentStatus(paymentStatus);
            if (extraCharges != null) existingBooking.setExtraCharges(extraCharges);
            if (extraChargesStatus != null) existingBooking.setExtraChargesStatus(extraChargesStatus);
            if (refundableAmount != null) existingBooking.setRefundableAmount(refundableAmount);
            if (refundableStatus != null) existingBooking.setRefundableStatus(refundableStatus);

            // Save the updated booking
            Booking updatedBooking = bookingService.saveBooking(existingBooking);
            return ResponseEntity.ok(updatedBooking);

        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }

    // Confirm booking
    @PostMapping("/{bookingNo}/confirm")
    public ResponseEntity<Booking> confirmBooking(
            @PathVariable String bookingNo,
            @RequestParam(required = false) String driverId) {

        try {
            Booking booking = bookingService.confirmBooking(bookingNo, driverId);
            return ResponseEntity.ok(booking);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    // Cancel booking
    @PostMapping("/{bookingNo}/cancel")
    public ResponseEntity<Booking> cancelBooking(@PathVariable String bookingNo) {
        try {
            Booking booking = bookingService.cancelBooking(bookingNo);
            return ResponseEntity.ok(booking);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    // Complete booking
    @PostMapping("/{bookingNo}/complete")
    public ResponseEntity<Booking> completeBooking(@PathVariable String bookingNo) {
        try {
            Booking booking = bookingService.completeBooking(bookingNo);
            return ResponseEntity.ok(booking);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    // Check car availability for a date range
    @GetMapping("/check-availability")
    public ResponseEntity<Map<String, Object>> checkAvailability(
            @RequestParam String carNo,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        try {
            List<Booking> conflictingBookings = bookingRepository.findConflictingBookings(
                    carNo, startDate, endDate);

            Map<String, Object> response = new HashMap<>();
            response.put("available", conflictingBookings.isEmpty());
            response.put("conflictingBookings", conflictingBookings);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    // Get bookings for a user
    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Booking>> getUserBookings(@PathVariable Long userId) {
        List<Booking> bookings = bookingService.getUserBookings(userId);
        return ResponseEntity.ok(bookings);
    }

    // Get bookings for a car
    @GetMapping("/car/{carNo}")
    public ResponseEntity<List<Booking>> getCarBookings(@PathVariable String carNo) {
        List<Booking> bookings = bookingRepository.findByCarNo(carNo);
        return ResponseEntity.ok(bookings);
    }

    // Get bookings for a driver
    @GetMapping("/driver/{driverId}")
    public ResponseEntity<List<Booking>> getDriverBookings(@PathVariable String driverId) {
        List<Booking> bookings = bookingRepository.findByDriverId(driverId);
        return ResponseEntity.ok(bookings);
    }
}