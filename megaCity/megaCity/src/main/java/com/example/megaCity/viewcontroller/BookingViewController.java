package com.example.megaCity.viewcontroller;

import com.example.megaCity.Model.Booking;
import com.example.megaCity.Model.User;
import com.example.megaCity.Repository.BookingRepository;
import com.example.megaCity.Service.BookingService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class BookingViewController {

    @Autowired
    private BookingService bookingService;

    @Autowired
    private BookingRepository bookingRepository;

    // Show bookings update page - removed authentication check for assignment purposes
    @GetMapping("/admin/updateBooking")
    public String showUpdateBookingPage(Model model, HttpSession session) {
        // Removed authentication check for assignment purposes

        // Get all bookings for the table
        List<Booking> bookings = bookingRepository.findAll();

        // Add dates in string format
        processBookingDates(model, bookings);

        // Initialize an empty booking for the form
        model.addAttribute("booking", new Booking());

        return "updateBooking";
    }

    // Helper method to process booking dates
    private void processBookingDates(Model model, List<Booking> bookings) {
        // Create maps to store formatted dates as strings
        Map<Long, String> startDates = new HashMap<>();
        Map<Long, String> endDates = new HashMap<>();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        for (Booking booking : bookings) {
            if (booking.getStartDate() != null) {
                startDates.put(booking.getId(), booking.getStartDate().format(formatter));
            } else {
                startDates.put(booking.getId(), "");
            }

            if (booking.getEndDate() != null) {
                endDates.put(booking.getId(), booking.getEndDate().format(formatter));
            } else {
                endDates.put(booking.getId(), "");
            }
        }

        model.addAttribute("startDates", startDates);
        model.addAttribute("endDates", endDates);
        model.addAttribute("bookings", bookings);
    }

    @GetMapping("/admin/bookings/edit/{bookingNo}")
    public String editBooking(@PathVariable String bookingNo, Model model) {
        Optional<Booking> bookingOpt = bookingService.getBookingByNumber(bookingNo);

        if (bookingOpt.isPresent()) {
            Booking booking = bookingOpt.get();
            model.addAttribute("booking", booking);

            // Add formatted dates as strings for the form
            if (booking.getStartDate() != null) {
                model.addAttribute("startDateStr", booking.getStartDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            }

            if (booking.getEndDate() != null) {
                model.addAttribute("endDateStr", booking.getEndDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            }

            // Get all bookings for the table
            List<Booking> bookings = bookingRepository.findAll();
            processBookingDates(model, bookings);
        } else {
            model.addAttribute("booking", new Booking());
            model.addAttribute("errorMessage", "Booking not found");

            // Get all bookings for the table
            List<Booking> bookings = bookingRepository.findAll();
            processBookingDates(model, bookings);
        }

        return "updateBooking";
    }

    @PostMapping("/admin/bookings/update")
    public String updateBooking(
            @RequestParam String bookingNo,
            @RequestParam(required = false) String carNo,
            @RequestParam(required = false) String customerNic,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate,
            @RequestParam(required = false) String destination,
            @RequestParam(required = false) Double startKm,
            @RequestParam(required = false) Double endKm,
            @RequestParam(required = false) String withDriverStr,
            @RequestParam(required = false) Double driverCost,
            @RequestParam(required = false) Double paidAmount,
            @RequestParam(required = false) String paymentStatus,
            @RequestParam(required = false) Double extraCharges,
            @RequestParam(required = false) String extraChargesStatus,
            @RequestParam(required = false) Double refundableAmount,
            @RequestParam(required = false) String refundableStatus,
            @RequestParam(required = false) Double totalBill,
            RedirectAttributes redirectAttributes) {

        try {
            Optional<Booking> existingBookingOpt = bookingService.getBookingByNumber(bookingNo);
            if (!existingBookingOpt.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Booking not found");
                return "redirect:/admin/updateBooking";
            }

            Booking existingBooking = existingBookingOpt.get();

            if (carNo != null && !carNo.isEmpty()) existingBooking.setCarNo(carNo);
            if (customerNic != null) existingBooking.setCustomerNic(customerNic);

            // Parse dates from string
            if (startDate != null && !startDate.isEmpty()) {
                existingBooking.setStartDate(LocalDate.parse(startDate));
            }

            if (endDate != null && !endDate.isEmpty()) {
                existingBooking.setEndDate(LocalDate.parse(endDate));
            }

            if (destination != null) existingBooking.setDestination(destination);
            if (startKm != null) existingBooking.setStartKm(startKm);
            if (endKm != null) existingBooking.setEndKm(endKm);
            if (withDriverStr != null) {
                boolean withDriver = "Yes".equalsIgnoreCase(withDriverStr);
                existingBooking.setWithDriver(withDriver);
            }
            if (driverCost != null) existingBooking.setDriverCost(driverCost);
            if (paidAmount != null) existingBooking.setPaidAmount(paidAmount);
            if (paymentStatus != null) existingBooking.setPaymentStatus(paymentStatus);
            if (extraCharges != null) existingBooking.setExtraCharges(extraCharges);
            if (extraChargesStatus != null) existingBooking.setExtraChargesStatus(extraChargesStatus);
            if (refundableAmount != null) existingBooking.setRefundableAmount(refundableAmount);
            if (refundableStatus != null) existingBooking.setRefundableStatus(refundableStatus);
            if (totalBill != null) existingBooking.setTotalAmount(totalBill);

            bookingService.saveBooking(existingBooking);
            redirectAttributes.addFlashAttribute("successMessage", "Booking updated successfully");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update booking: " + e.getMessage());
        }

        return "redirect:/admin/updateBooking";
    }

    // Modified search method to include formatted dates
    @GetMapping("/admin/bookings/search")
    public String searchBookings(@RequestParam String query, Model model) {
        List<Booking> bookings = bookingRepository.searchBookings(query);

        // Process dates for proper display
        processBookingDates(model, bookings);

        // Add empty booking for the form
        model.addAttribute("booking", new Booking());
        model.addAttribute("searchQuery", query);

        return "updateBooking";
    }
}