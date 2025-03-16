package com.example.megaCity.Controller;

import com.example.megaCity.Model.Booking;
import com.example.megaCity.Model.Car;
import com.example.megaCity.Model.Driver;
import com.example.megaCity.Model.User;
import com.example.megaCity.Repository.CarRepository;
import com.example.megaCity.Repository.UserRepository;
import com.example.megaCity.Service.BookingService;
import com.example.megaCity.Service.DriverService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/bookings")
public class AdminBookingController {

    @Autowired private BookingService bookingService;
    @Autowired private DriverService driverService;
    @Autowired private CarRepository carRepository;
    @Autowired private UserRepository userRepository;

    // Check if user is admin
    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return user != null && "ADMIN".equals(user.getUserType());
    }

    // Booking management page
    @GetMapping
    public String bookingManagement(HttpSession session, Model model) {
        // Check if user is admin
        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        // Get bookings by status
        List<Booking> pendingBookings = bookingService.getBookingsByStatus("PENDING");
        List<Booking> confirmedBookings = bookingService.getBookingsByStatus("CONFIRMED");
        List<Booking> completedBookings = bookingService.getBookingsByStatus("COMPLETED");
        List<Booking> cancelledBookings = bookingService.getBookingsByStatus("CANCELLED");

        // Add bookings to model
        model.addAttribute("pendingBookings", pendingBookings);
        model.addAttribute("confirmedBookings", confirmedBookings);
        model.addAttribute("completedBookings", completedBookings);
        model.addAttribute("cancelledBookings", cancelledBookings);

        return "admin/bookings";
    }

    // Booking details page
    @GetMapping("/{bookingNo}")
    public String bookingDetails(@PathVariable String bookingNo,
                                 HttpSession session,
                                 Model model) {
        // Check if user is admin
        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        // Get booking
        Optional<Booking> bookingOpt = bookingService.getBookingByNumber(bookingNo);
        if (!bookingOpt.isPresent()) {
            model.addAttribute("error", "Booking not found");
            return "error";
        }

        Booking booking = bookingOpt.get();

        // Add booking to model
        model.addAttribute("booking", booking);

        // Add car details
        carRepository.findById(booking.getCarNo()).ifPresent(car -> {
            model.addAttribute("car", car);
        });

        // Add user details
        userRepository.findById(booking.getUserId()).ifPresent(user -> {
            model.addAttribute("customer", user);
        });

        // Add driver details if assigned
        if (booking.getDriverId() != null && !booking.getDriverId().isEmpty()) {
            driverService.getDriverById(booking.getDriverId()).ifPresent(driver -> {
                model.addAttribute("driver", driver);
            });
        }

        // Add available drivers if booking is with driver and pending
        if (booking.isWithDriver() && "PENDING".equals(booking.getStatus())) {
            List<Driver> availableDrivers = driverService.getAvailableDrivers();
            model.addAttribute("availableDrivers", availableDrivers);
        }

        return "admin/bookingDetails";
    }

    // Confirm booking
    @PostMapping("/confirm/{bookingNo}")
    public String confirmBooking(@PathVariable String bookingNo,
                                 @RequestParam(required = false) String driverId,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        // Check if user is admin
        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        try {
            // Confirm booking
            bookingService.confirmBooking(bookingNo, driverId);

            // Add success message
            redirectAttributes.addFlashAttribute("success", "Booking confirmed successfully");

        } catch (Exception e) {
            // Add error message
            redirectAttributes.addFlashAttribute("error", "Failed to confirm booking: " + e.getMessage());
        }

        return "redirect:/admin/bookings/" + bookingNo;
    }

    // Cancel booking
    @PostMapping("/cancel/{bookingNo}")
    public String cancelBooking(@PathVariable String bookingNo,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        // Check if user is admin
        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        try {
            // Cancel booking
            bookingService.cancelBooking(bookingNo);

            // Add success message
            redirectAttributes.addFlashAttribute("success", "Booking cancelled successfully");

        } catch (Exception e) {
            // Add error message
            redirectAttributes.addFlashAttribute("error", "Failed to cancel booking: " + e.getMessage());
        }

        return "redirect:/admin/bookings/" + bookingNo;
    }

    // Complete booking
    @PostMapping("/complete/{bookingNo}")
    public String completeBooking(@PathVariable String bookingNo,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        // Check if user is admin
        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        try {
            // Complete booking
            bookingService.completeBooking(bookingNo);

            // Add success message
            redirectAttributes.addFlashAttribute("success", "Booking marked as completed successfully");

        } catch (Exception e) {
            // Add error message
            redirectAttributes.addFlashAttribute("error", "Failed to complete booking: " + e.getMessage());
        }

        return "redirect:/admin/bookings/" + bookingNo;
    }
}