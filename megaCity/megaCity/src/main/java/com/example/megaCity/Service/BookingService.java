package com.example.megaCity.Service;

import com.example.megaCity.Model.Booking;
import com.example.megaCity.Model.Car;
import com.example.megaCity.Model.User;
import com.example.megaCity.Repository.BookingRepository;
import com.example.megaCity.Repository.CarRepository;
import com.example.megaCity.Repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.logging.Logger;

@Service
public class BookingService {
    private static final Logger logger = Logger.getLogger(BookingService.class.getName());

    @Autowired private BookingRepository bookingRepository;
    @Autowired private CarRepository carRepository;
    @Autowired private UserRepository userRepository;
    @Autowired private DriverService driverService;

    private final String BILL_DIR = "./bills";

    // Create a new booking
    public Booking createBooking(String carNo, Long userId, LocalDate startDate, LocalDate endDate,
                                 boolean withDriver, String message) throws Exception {

        // Check if car exists
        Optional<Car> carOpt = carRepository.findById(carNo);
        if (!carOpt.isPresent()) {
            throw new Exception("Car not found with ID: " + carNo);
        }

        // Check if user exists
        Optional<User> userOpt = userRepository.findById(userId);
        if (!userOpt.isPresent()) {
            throw new Exception("User not found with ID: " + userId);
        }

        // Check for booking conflicts
        List<Booking> conflictingBookings = bookingRepository.findConflictingBookings(
                carNo, startDate, endDate);
        if (!conflictingBookings.isEmpty()) {
            throw new Exception("Car is not available for the selected dates");
        }

        // Create booking
        Booking booking = new Booking();
        booking.setBookingNo(generateBookingNumber());
        booking.setCarNo(carNo);
        booking.setUserId(userId);
        booking.setStartDate(startDate);
        booking.setEndDate(endDate);
        booking.setWithDriver(withDriver);
        booking.setMessage(message);
        booking.setStatus("PENDING");
        booking.setCreatedAt(LocalDateTime.now());

        // Initialize new fields
        booking.setPaymentStatus("Pending");
        booking.setExtraChargesStatus("No Charges");
        booking.setRefundableStatus("No Refund");
        booking.setExtraCharges(0.0);
        booking.setRefundableAmount(0.0);
        booking.setPaidAmount(0.0);

        // Set customer NIC if available
        if (userOpt.get().getNicOrPassport() != null && !userOpt.get().getNicOrPassport().isEmpty()) {
            booking.setCustomerNic(userOpt.get().getNicOrPassport());
        }

        // Calculate total amount
        Car car = carOpt.get();
        long days = ChronoUnit.DAYS.between(startDate, endDate) + 1; // inclusive of start and end date
        double totalAmount = car.getPrice() * days;

        // Add driver cost if requested (25% of car price)
        if (withDriver) {
            double driverCost = car.getPrice() * 0.25 * days;
            booking.setDriverCost(driverCost);
            totalAmount += driverCost;
        } else {
            booking.setDriverCost(0.0);
        }

        booking.setTotalAmount(totalAmount);

        // Save booking
        booking = bookingRepository.save(booking);

        // Generate initial bill PDF
        try {
            String billPath = generateBillPdf(booking, false);
            booking.setBillUrl(billPath);
            return bookingRepository.save(booking);
        } catch (Exception e) {
            logger.severe("Error generating bill: " + e.getMessage());
            throw e;
        }
    }

    // Get a booking by ID
    public Optional<Booking> getBookingById(Long id) {
        return bookingRepository.findById(id);
    }

    // Get a booking by booking number
    public Optional<Booking> getBookingByNumber(String bookingNo) {
        return bookingRepository.findByBookingNo(bookingNo);
    }

    // Get bookings by customer NIC
    public List<Booking> getBookingsByCustomerNic(String customerNic) {
        return bookingRepository.findByCustomerNic(customerNic);
    }

    // Get all bookings for a user
    public List<Booking> getUserBookings(Long userId) {
        return bookingRepository.findByUserId(userId);
    }

    // Get all bookings by status
    public List<Booking> getBookingsByStatus(String status) {
        return bookingRepository.findByStatus(status);
    }

    // Confirm a booking
    public Booking confirmBooking(String bookingNo, String driverId) throws Exception {
        Optional<Booking> bookingOpt = bookingRepository.findByBookingNo(bookingNo);
        if (!bookingOpt.isPresent()) {
            throw new Exception("Booking not found with number: " + bookingNo);
        }

        Booking booking = bookingOpt.get();

        // Check if booking can be confirmed
        if (!"PENDING".equals(booking.getStatus())) {
            throw new Exception("Booking cannot be confirmed because it is in " + booking.getStatus() + " state");
        }

        // Assign driver if booking is with driver
        if (booking.isWithDriver()) {
            if (driverId == null || driverId.isEmpty()) {
                throw new Exception("Driver ID must be provided for bookings with driver");
            }

            // Check if driver exists and is available
            boolean updated = driverService.updateDriverAvailability(driverId, false, bookingNo).isAvailable();
            if (!updated) {
                throw new Exception("Driver not found or not available");
            }

            booking.setDriverId(driverId);
        }

        booking.setStatus("CONFIRMED");
        booking.setConfirmationDate(LocalDateTime.now());

        // Generate final bill PDF
        String finalBillPath = generateBillPdf(booking, true);
        booking.setFinalBillUrl(finalBillPath);

        return bookingRepository.save(booking);
    }

    // Cancel a booking
    public Booking cancelBooking(String bookingNo) throws Exception {
        Optional<Booking> bookingOpt = bookingRepository.findByBookingNo(bookingNo);
        if (!bookingOpt.isPresent()) {
            throw new Exception("Booking not found with number: " + bookingNo);
        }

        Booking booking = bookingOpt.get();

        // Check if booking can be cancelled
        if (!"PENDING".equals(booking.getStatus()) && !"CONFIRMED".equals(booking.getStatus())) {
            throw new Exception("Booking cannot be cancelled because it is in " + booking.getStatus() + " state");
        }

        // If a driver was assigned, make them available again
        if (booking.getDriverId() != null && !booking.getDriverId().isEmpty()) {
            driverService.updateDriverAvailability(booking.getDriverId(), true, null);
        }

        booking.setStatus("CANCELLED");
        return bookingRepository.save(booking);
    }

    // Complete a booking
    public Booking completeBooking(String bookingNo) throws Exception {
        Optional<Booking> bookingOpt = bookingRepository.findByBookingNo(bookingNo);
        if (!bookingOpt.isPresent()) {
            throw new Exception("Booking not found with number: " + bookingNo);
        }

        Booking booking = bookingOpt.get();

        // Check if booking can be completed
        if (!"CONFIRMED".equals(booking.getStatus())) {
            throw new Exception("Booking cannot be completed because it is in " + booking.getStatus() + " state");
        }

        // If a driver was assigned, make them available again
        if (booking.getDriverId() != null && !booking.getDriverId().isEmpty()) {
            driverService.updateDriverAvailability(booking.getDriverId(), true, null);
        }

        booking.setStatus("COMPLETED");

        // Generate final bill with all charges
        String finalBillPath = generateBillPdf(booking, true);
        booking.setFinalBillUrl(finalBillPath);

        return bookingRepository.save(booking);
    }

    // Generate a unique booking number
    private String generateBookingNumber() {
        return "BK" + System.currentTimeMillis() + UUID.randomUUID().toString().substring(0, 4).toUpperCase();
    }

    // Generate bill PDF (text file with .pdf extension)
    private String generateBillPdf(Booking booking, boolean isFinal) throws IOException {
        // Create directory if it doesn't exist
        Path billsDir = Paths.get(BILL_DIR);
        if (!Files.exists(billsDir)) {
            Files.createDirectories(billsDir);
        }

        // Create file name
        String fileName = isFinal ?
                "final_bill_" + booking.getBookingNo() + ".pdf" :
                "bill_" + booking.getBookingNo() + ".pdf";

        String filePath = BILL_DIR + "/" + fileName;

        // Create a simple text file as placeholder
        File file = new File(filePath);
        try (FileOutputStream fos = new FileOutputStream(file)) {
            StringBuilder content = new StringBuilder();
            content.append("MEGA CITY CAB - ").append(isFinal ? "FINAL" : "PROVISIONAL").append(" RECEIPT\n\n");
            content.append("Booking No: ").append(booking.getBookingNo()).append("\n");
            content.append("Date: ").append(LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm"))).append("\n\n");

            // Add customer details
            User user = userRepository.findById(booking.getUserId()).orElse(null);
            if (user != null) {
                content.append("Customer: ").append(user.getFirstName()).append(" ").append(user.getLastName()).append("\n");
                content.append("Email: ").append(user.getEmail()).append("\n");
                if (booking.getCustomerNic() != null && !booking.getCustomerNic().isEmpty()) {
                    content.append("NIC/Passport: ").append(booking.getCustomerNic()).append("\n");
                }
                content.append("\n");
            }

            // Add car details
            Car car = carRepository.findById(booking.getCarNo()).orElse(null);
            if (car != null) {
                content.append("Car: ").append(car.getName()).append(" (").append(car.getBrand()).append(")\n");
                content.append("Car No: ").append(car.getCarNo()).append("\n\n");
            }

            // Add booking details
            content.append("Start Date: ").append(booking.getStartDate().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))).append("\n");
            content.append("End Date: ").append(booking.getEndDate().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))).append("\n");
            content.append("With Driver: ").append(booking.isWithDriver() ? "Yes" : "No").append("\n");

            if (booking.getDestination() != null && !booking.getDestination().isEmpty()) {
                content.append("Destination: ").append(booking.getDestination()).append("\n");
            }

            if (booking.getStartKm() != null) {
                content.append("Start KM: ").append(String.format("%.1f", booking.getStartKm())).append(" km\n");
            }

            if (booking.getEndKm() != null) {
                content.append("End KM: ").append(String.format("%.1f", booking.getEndKm())).append(" km\n");

                if (booking.getStartKm() != null) {
                    double distanceTraveled = booking.getEndKm() - booking.getStartKm();
                    content.append("Distance Traveled: ").append(String.format("%.1f", distanceTraveled)).append(" km\n");
                }
            }

            content.append("\n");

            // Add cost details
            long days = ChronoUnit.DAYS.between(booking.getStartDate(), booking.getEndDate()) + 1;
            double carCost = car != null ? car.getPrice() * days : 0;

            content.append("Car Rental: Rs. ").append(String.format("%.2f", carCost)).append("\n");

            if (booking.getDriverCost() != null && booking.getDriverCost() > 0) {
                content.append("Driver Fee: Rs. ").append(String.format("%.2f", booking.getDriverCost())).append("\n");
            }

            if (booking.getExtraCharges() != null && booking.getExtraCharges() > 0) {
                content.append("Extra Charges: Rs. ").append(String.format("%.2f", booking.getExtraCharges())).append("\n");
                content.append("Extra Charges Status: ").append(booking.getExtraChargesStatus()).append("\n");
            }

            if (booking.getRefundableAmount() != null && booking.getRefundableAmount() > 0) {
                content.append("Refundable Amount: Rs. ").append(String.format("%.2f", booking.getRefundableAmount())).append("\n");
                content.append("Refundable Status: ").append(booking.getRefundableStatus()).append("\n");
            }

            // Calculate total bill
            double totalBill = booking.getTotalAmount();
            if (booking.getExtraCharges() != null) {
                totalBill += booking.getExtraCharges();
            }
            if (booking.getRefundableAmount() != null) {
                totalBill -= booking.getRefundableAmount();
            }

            content.append("Total Amount: Rs. ").append(String.format("%.2f", totalBill)).append("\n");

            if (booking.getPaidAmount() != null) {
                content.append("Paid Amount: Rs. ").append(String.format("%.2f", booking.getPaidAmount())).append("\n");
                content.append("Payment Status: ").append(booking.getPaymentStatus()).append("\n");

                // Calculate balance
                double balance = totalBill - booking.getPaidAmount();
                if (balance > 0) {
                    content.append("Balance Due: Rs. ").append(String.format("%.2f", balance)).append("\n");
                } else if (balance < 0) {
                    content.append("Overpaid Amount: Rs. ").append(String.format("%.2f", Math.abs(balance))).append("\n");
                }
            }

            content.append("\nStatus: ").append(booking.getStatus()).append("\n\n");
            content.append("Thank you for choosing Mega City Cab!");

            // Write content to file
            fos.write(content.toString().getBytes());
        }

        return fileName;
    }

    // Generate a regular bill for a booking
    public String generateBill(Booking booking) throws IOException {
        return generateBillPdf(booking, false);
    }

    // Generate a final bill for a booking
    public String generateFinalBill(Booking booking) throws IOException {
        return generateBillPdf(booking, true);
    }

    public Booking saveBooking(Booking booking) {
        return bookingRepository.save(booking);
    }

    public BookingRepository getBookingRepository() {
        return bookingRepository;
    }
}