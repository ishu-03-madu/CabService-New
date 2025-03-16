package com.example.megaCity.Controller;

import com.example.megaCity.Model.Booking;
import com.example.megaCity.Model.Car;
import com.example.megaCity.Model.Driver;
import com.example.megaCity.Model.User;
import com.example.megaCity.Repository.BookingRepository;
import com.example.megaCity.Repository.CarRepository;
import com.example.megaCity.Service.BookingService;
import com.example.megaCity.Service.DriverService;
import com.example.megaCity.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/admin")
public class AdminRestController {
    @Autowired private CarRepository carRepository;
    @Autowired private UserService userService;
    @Autowired private BookingService bookingService;
    @Autowired private DriverService driverService;
    @Autowired private BookingRepository bookingRepository;

    private final String UPLOAD_DIR = "./images";

    @GetMapping("/cars")
    public List<Car> getAllCars() {
        return carRepository.findAll();
    }

    @GetMapping("/cars/{carNo}")
    public ResponseEntity<Car> getCarByCarNo(@PathVariable String carNo) {
        return carRepository.findById(carNo)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping("/cars")
    public ResponseEntity<Car> addCar(@RequestBody Car car) {
        carRepository.save(car);
        return ResponseEntity.ok(car);
    }

    @PostMapping("/cars/{carNo}/image")
    public ResponseEntity<?> uploadCarImage(@PathVariable String carNo,
                                            @RequestParam("image") MultipartFile image) throws IOException {
        Optional<Car> optionalCar = carRepository.findById(carNo);
        if (optionalCar.isEmpty()) return ResponseEntity.notFound().build();

        Car car = optionalCar.get();

        if (image != null && !image.isEmpty()) {
            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (!Files.exists(uploadPath)) Files.createDirectories(uploadPath);

            String filename = System.currentTimeMillis() + "_" + image.getOriginalFilename().replaceAll("\\s+", "_");
            Files.copy(image.getInputStream(), uploadPath.resolve(filename));

            car.setImages(filename);
            carRepository.save(car);

            return ResponseEntity.ok(Map.of("message", "Image uploaded successfully"));
        }

        return ResponseEntity.badRequest().body("No image provided");
    }

    @PutMapping("/cars/{carNo}")
    public ResponseEntity<Car> updateCar(@PathVariable String carNo, @RequestBody Car car) {
        if (!carRepository.existsById(carNo)) {
            return ResponseEntity.notFound().build();
        }

        car.setCarNo(carNo); // Ensure ID matches path variable
        carRepository.save(car);
        return ResponseEntity.ok(car);
    }

    @DeleteMapping("/cars/{carNo}")
    public ResponseEntity<Void> deleteCar(@PathVariable String carNo) {
        if (!carRepository.existsById(carNo)) {
            return ResponseEntity.notFound().build();
        }carRepository.deleteById(carNo);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/users")
    public List<User> getAllUsers() { return userService.getAllUsers();}

    @GetMapping("/users/customers")
    public List<User> getAllCustomers() {return userService.getAllCustomers();}

    @GetMapping("/users/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Long id) {
        return userService.getUserById(id)
                .map(user -> ResponseEntity.ok(user))
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/users")
    public ResponseEntity<User> createUser(@RequestBody User user) {
        return ResponseEntity.status(HttpStatus.CREATED).body(userService.saveUser(user));
    }

    @PutMapping("/users/{id}")
    public ResponseEntity<User> updateUser(@PathVariable Long id, @RequestBody User user) {
        if (!userService.getUserById(id).isPresent()) {
            return ResponseEntity.notFound().build();
        }
        user.setId(id);
        return ResponseEntity.ok(userService.saveUser(user));
    }

    @DeleteMapping("/users/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        if (!userService.getUserById(id).isPresent()) {
            return ResponseEntity.notFound().build();
        }
        userService.deleteUser(id);
        return ResponseEntity.noContent().build();
    }

    // Dashboard Statistics
    @GetMapping("/dashboard")
    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalCars", carRepository.count());
        stats.put("totalCustomers", userService.getAllCustomers().size());

        // Add booking statistics
        stats.put("pendingBookings", bookingService.getBookingsByStatus("PENDING").size());
        stats.put("confirmedBookings", bookingService.getBookingsByStatus("CONFIRMED").size());
        stats.put("completedBookings", bookingService.getBookingsByStatus("COMPLETED").size());
        stats.put("cancelledBookings", bookingService.getBookingsByStatus("CANCELLED").size());

        return stats;
    }

    // ---------- BOOKING MANAGEMENT ENDPOINTS ----------

    // Get all bookings with optional status filtering
    @GetMapping("/bookings")
    public ResponseEntity<Map<String, Object>> getAllBookings(
            @RequestParam(required = false) String status,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {

        List<Booking> bookings;
        if (status != null && !status.isEmpty()) {
            bookings = bookingService.getBookingsByStatus(status);
        } else {
            bookings = bookingService.getBookingsByStatus("PENDING");
        }

        // Simple pagination (in a real app, use Spring Data's PageRequest)
        int start = Math.min(page * size, bookings.size());
        int end = Math.min((page + 1) * size, bookings.size());
        List<Booking> pagedBookings = bookings.subList(start, end);

        Map<String, Object> response = new HashMap<>();
        response.put("bookings", pagedBookings);
        response.put("currentPage", page);
        response.put("totalItems", bookings.size());
        response.put("totalPages", (int) Math.ceil((double) bookings.size() / size));

        return ResponseEntity.ok(response);
    }

    // Get booking by number
    @GetMapping("/bookings/{bookingNo}")
    public ResponseEntity<Booking> getBookingByNumber(@PathVariable String bookingNo) {
        return bookingService.getBookingByNumber(bookingNo)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Search bookings by booking number or customer NIC
    @GetMapping("/bookings/search")
    public ResponseEntity<List<Booking>> searchBookings(@RequestParam String query) {
        List<Booking> bookings = bookingRepository.searchBookings(query);
        return ResponseEntity.ok(bookings);
    }

    // Update booking details
    @PutMapping("/bookings/{bookingNo}")
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
            @RequestParam(required = false) String refundableStatus,
            @RequestParam(required = false) Double totalBill) {

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
            if (totalBill != null) existingBooking.setTotalAmount(totalBill);

            // Save the updated booking
            Booking updatedBooking = bookingService.saveBooking(existingBooking);
            return ResponseEntity.ok(updatedBooking);

        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }

    // Confirm a booking
    @PostMapping("/bookings/{bookingNo}/confirm")
    public ResponseEntity<?> confirmBooking(
            @PathVariable String bookingNo,
            @RequestParam(required = false) String driverId) {

        try {
            // Check if we need to assign a driver
            Optional<Booking> bookingOpt = bookingService.getBookingByNumber(bookingNo);
            if (!bookingOpt.isPresent()) {
                return ResponseEntity.notFound().build();
            }

            Booking booking = bookingOpt.get();

            // If booking requires a driver but none provided
            if (booking.isWithDriver() && (driverId == null || driverId.isEmpty())) {
                // Get available drivers
                List<Driver> availableDrivers = driverService.getAvailableDrivers();

                if (availableDrivers.isEmpty()) {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                            .body(Map.of("error", "No available drivers to assign"));
                }

                // Return available drivers instead of confirming
                return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY)
                        .body(Map.of(
                                "message", "Booking requires driver assignment",
                                "availableDrivers", availableDrivers
                        ));
            }

            // Confirm the booking
            Booking confirmedBooking = bookingService.confirmBooking(bookingNo, driverId);
            return ResponseEntity.ok(confirmedBooking);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("error", e.getMessage()));
        }
    }

    // Cancel a booking
    @PostMapping("/bookings/{bookingNo}/cancel")
    public ResponseEntity<?> cancelBooking(@PathVariable String bookingNo) {
        try {
            Booking cancelledBooking = bookingService.cancelBooking(bookingNo);
            return ResponseEntity.ok(cancelledBooking);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("error", e.getMessage()));
        }
    }

    // Complete a booking
    @PostMapping("/bookings/{bookingNo}/complete")
    public ResponseEntity<?> completeBooking(@PathVariable String bookingNo) {
        try {
            Booking completedBooking = bookingService.completeBooking(bookingNo);
            return ResponseEntity.ok(completedBooking);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("error", e.getMessage()));
        }
    }

    // Delete a booking
    @DeleteMapping("/bookings/{bookingNo}")
    public ResponseEntity<?> deleteBooking(@PathVariable String bookingNo) {
        try {
            Optional<Booking> bookingOpt = bookingService.getBookingByNumber(bookingNo);
            if (!bookingOpt.isPresent()) {
                return ResponseEntity.notFound().build();
            }

            bookingRepository.delete(bookingOpt.get());
            return ResponseEntity.ok(Map.of("message", "Booking deleted successfully"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("error", e.getMessage()));
        }
    }

    // Get available drivers for assignment
    @GetMapping("/available-drivers")
    public ResponseEntity<List<Driver>> getAvailableDrivers() {
        List<Driver> availableDrivers = driverService.getAvailableDrivers();
        return ResponseEntity.ok(availableDrivers);
    }

    // Assign a driver to a booking
    @PostMapping("/bookings/{bookingNo}/assign-driver")
    public ResponseEntity<?> assignDriver(
            @PathVariable String bookingNo,
            @RequestParam String driverId) {

        try {
            // Get the booking
            Optional<Booking> bookingOpt = bookingService.getBookingByNumber(bookingNo);
            if (!bookingOpt.isPresent()) {
                return ResponseEntity.notFound().build();
            }

            Booking booking = bookingOpt.get();

            // Check if booking requires a driver
            if (!booking.isWithDriver()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Map.of("error", "This booking does not require a driver"));
            }

            // Check if booking already has a driver assigned
            if (booking.getDriverId() != null && !booking.getDriverId().isEmpty()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Map.of("error", "This booking already has a driver assigned"));
            }

            // Update driver availability
            boolean updated = driverService.updateDriverAvailability(driverId, false, bookingNo).isAvailable();
            if (!updated) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Map.of("error", "Driver not found or not available"));
            }

            // Update booking with driver id
            booking.setDriverId(driverId);
            Booking updatedBooking = bookingService.saveBooking(booking);

            return ResponseEntity.ok(updatedBooking);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("error", e.getMessage()));
        }
    }
}