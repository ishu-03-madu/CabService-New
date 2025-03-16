package com.example.megaCity.Controller;

import com.example.megaCity.Model.Booking;
import com.example.megaCity.Model.Car;
import com.example.megaCity.Model.User;
import com.example.megaCity.Repository.CarRepository;
import com.example.megaCity.Service.BookingService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

@Controller
public class BookingController {

    private static final Logger logger = Logger.getLogger(BookingController.class.getName());

    @Autowired
    private BookingService bookingService;
    @Autowired
    private CarRepository carRepository;

    private final String BILL_DIR = "./bills";

    @PostMapping("/book-car")
    public String bookCar(@RequestParam String carNo,
                          @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
                          @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
                          @RequestParam(required = false, defaultValue = "false") boolean withDriver,
                          @RequestParam(required = false) String message,
                          HttpSession session,
                          Model model,
                          RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "You must be logged in to book a car");
            return "redirect:/login?redirect=carStructured?carNo=" + carNo;
        }
        try {
            Optional<Car> carOpt = carRepository.findById(carNo);
            if (!carOpt.isPresent()) {
                throw new Exception("Car not found with ID: " + carNo);
            }
            Car car = carOpt.get();
            List<Booking> conflictingBookings = bookingService.getBookingRepository().findConflictingBookings(carNo, startDate, endDate);
            if (!conflictingBookings.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Car is not available for the selected dates");
                return "redirect:/carStructured?carNo=" + carNo;
            }
            Booking booking = new Booking();
            booking.setBookingNo("BK" + System.currentTimeMillis());
            booking.setCarNo(carNo);
            booking.setUserId(user.getId());
            booking.setStartDate(startDate);
            booking.setEndDate(endDate);
            booking.setWithDriver(withDriver);
            booking.setMessage(message);
            booking.setStatus("PENDING");
            booking.setCreatedAt(LocalDateTime.now());
            if (user.getNicOrPassport() != null && !user.getNicOrPassport().isEmpty()) {
                booking.setCustomerNic(user.getNicOrPassport());
            }
            booking.setPaymentStatus("Pending");
            booking.setExtraChargesStatus("No Charges");
            booking.setRefundableStatus("No Refund");
            booking.setExtraCharges(0.0);
            booking.setRefundableAmount(0.0);
            booking.setPaidAmount(0.0);
            long days = java.time.temporal.ChronoUnit.DAYS.between(startDate, endDate) + 1;
            double totalAmount = car.getPrice() * days;
            if (withDriver) {
                double driverCost = car.getPrice() * 0.25 * days;
                booking.setDriverCost(driverCost);
                totalAmount += driverCost;
            } else {
                booking.setDriverCost(0.0);
            }
            booking.setTotalAmount(totalAmount);

            // Save the booking to database first
            booking = bookingService.saveBooking(booking);

            model.addAttribute("booking", booking);
            model.addAttribute("car", car);
            return "receipt";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to create booking: " + e.getMessage());
            return "redirect:/carStructured?carNo=" + carNo;
        }
    }

    @PostMapping("/payment")
    public String processPaymentRedirect(
            @RequestParam String bookingNo,
            HttpServletRequest request,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            // Log the received bookingNo for debugging
            logger.info("Processing payment for booking number: " + bookingNo);

            Optional<Booking> bookingOpt = bookingService.getBookingByNumber(bookingNo);
            if (!bookingOpt.isPresent()) {
                logger.warning("Booking not found with number: " + bookingNo);
                redirectAttributes.addFlashAttribute("error", "Booking not found");
                return "redirect:/home";
            }

            Booking booking = bookingOpt.get();

            // Set destination if provided
            if (request.getParameter("destination") != null && !request.getParameter("destination").isEmpty()) {
                booking.setDestination(request.getParameter("destination"));
                bookingService.saveBooking(booking);
            }

            // For displaying the payment page
            model.addAttribute("booking", booking);
            carRepository.findById(booking.getCarNo()).ifPresent(car -> {
                model.addAttribute("car", car);
            });

            return "payment";
        } catch (Exception e) {
            logger.severe("Error processing payment: " + e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Error processing booking: " + e.getMessage());
            return "redirect:/home";
        }
    }

    @PostMapping("/process-payment")
    public String processPayment(
            @RequestParam String bookingNo,
            @RequestParam String paymentMethod,
            HttpServletRequest request,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            logger.info("Processing final payment for booking number: " + bookingNo);

            Optional<Booking> bookingOpt = bookingService.getBookingByNumber(bookingNo);
            if (!bookingOpt.isPresent()) {
                logger.warning("Booking not found with number: " + bookingNo);
                redirectAttributes.addFlashAttribute("error", "Booking not found");
                return "redirect:/home";
            }

            Booking booking = bookingOpt.get();

            // Update booking status to confirmed
            booking.setStatus("CONFIRMED");
            booking.setConfirmationDate(LocalDateTime.now());

            // Set the payment as completed
            booking.setPaidAmount(booking.getTotalAmount());

            // Update payment status based on method
            if ("online".equals(paymentMethod)) {
                booking.setPaymentStatus("Online Payment Done");
            } else if ("cash".equals(paymentMethod)) {
                booking.setPaymentStatus("Cash Payment");
            }

            // Save the updated booking
            bookingService.saveBooking(booking);

            return "redirect:/booking-confirmation?bookingNo=" + bookingNo;
        } catch (Exception e) {
            logger.severe("Error processing payment: " + e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Error processing payment: " + e.getMessage());
            return "redirect:/home";
        }
    }

    @GetMapping("/booking-confirmation")
    public String bookingConfirmation(@RequestParam(required = false) String bookingNo,
                                      HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        if (bookingNo == null || bookingNo.trim().isEmpty()) {
            model.addAttribute("error", "Booking number is required");
            return "error";
        }
        Optional<Booking> bookingOpt = bookingService.getBookingByNumber(bookingNo);
        if (!bookingOpt.isPresent()) {
            model.addAttribute("error", "Booking not found");
            return "error";
        }
        Booking booking = bookingOpt.get();
        if (!booking.getUserId().equals(user.getId())) {
            model.addAttribute("error", "You don't have permission to view this booking");
            return "error";
        }
        model.addAttribute("booking", booking);
        carRepository.findById(booking.getCarNo()).ifPresent(car -> {
            model.addAttribute("car", car);
        });
        return "bookingConfirmation";
    }

    // Other methods (unchanged for brevity)
    @GetMapping("/payment")
    public String payment(@RequestParam String bookingNo, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        Optional<Booking> bookingOpt = bookingService.getBookingByNumber(bookingNo);
        if (!bookingOpt.isPresent()) {
            model.addAttribute("error", "Booking not found");
            return "error";
        }
        Booking booking = bookingOpt.get();
        if (!booking.getUserId().equals(user.getId())) {
            model.addAttribute("error", "You don't have permission to view this booking");
            return "error";
        }
        model.addAttribute("booking", booking);
        carRepository.findById(booking.getCarNo()).ifPresent(car -> {
            model.addAttribute("car", car);
        });
        return "payment";
    }

    @GetMapping("/my-bookings")
    public String myBookings(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        List<Booking> bookings = bookingService.getUserBookings(user.getId());
        model.addAttribute("bookings", bookings);
        for (Booking booking : bookings) {
            Optional<Car> carOpt = carRepository.findById(booking.getCarNo());
            if (carOpt.isPresent()) {
                model.addAttribute("car_" + booking.getId(), carOpt.get());
            }
        }
        return "myBookings";
    }

    @GetMapping("/cancel-booking/{bookingNo}")
    public String cancelBooking(@PathVariable String bookingNo,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        try {
            Optional<Booking> bookingOpt = bookingService.getBookingByNumber(bookingNo);
            if (!bookingOpt.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Booking not found");
                return "redirect:/my-bookings";
            }
            Booking booking = bookingOpt.get();
            if (!booking.getUserId().equals(user.getId())) {
                redirectAttributes.addFlashAttribute("error", "You don't have permission to cancel this booking");
                return "redirect:/my-bookings";
            }
            bookingService.cancelBooking(bookingNo);
            redirectAttributes.addFlashAttribute("success", "Booking cancelled successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to cancel booking: " + e.getMessage());
        }
        return "redirect:/my-bookings";
    }

    @GetMapping("/download-bill/{bookingNo}")
    public void downloadBill(@PathVariable String bookingNo,
                             @RequestParam(required = false, defaultValue = "false") boolean finalBill,
                             HttpSession session,
                             HttpServletResponse response) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("/login");
            return;
        }

        try {
            Optional<Booking> bookingOpt = bookingService.getBookingByNumber(bookingNo);
            if (!bookingOpt.isPresent()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Booking not found");
                return;
            }

            Booking booking = bookingOpt.get();
            if (!booking.getUserId().equals(user.getId()) && !"ADMIN".equals(user.getUserType())) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "You don't have permission to download this bill");
                return;
            }

            String fileName = finalBill ? booking.getFinalBillUrl() : booking.getBillUrl();
            if (fileName == null || fileName.isEmpty()) {
                // Generate bill on the fly if it doesn't exist
                if (finalBill) {
                    fileName = bookingService.generateFinalBill(booking);
                    booking.setFinalBillUrl(fileName);
                } else {
                    fileName = bookingService.generateBill(booking);
                    booking.setBillUrl(fileName);
                }
                bookingService.saveBooking(booking);
            }

            Path filePath = Paths.get(BILL_DIR, fileName);
            if (!Files.exists(filePath)) {
                // Regenerate file if it doesn't exist on disk
                if (finalBill) {
                    fileName = bookingService.generateFinalBill(booking);
                    booking.setFinalBillUrl(fileName);
                } else {
                    fileName = bookingService.generateBill(booking);
                    booking.setBillUrl(fileName);
                }
                bookingService.saveBooking(booking);
                filePath = Paths.get(BILL_DIR, fileName);
            }

            // Set the content type
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

            // Copy the file to the output stream
            Files.copy(filePath, response.getOutputStream());
            response.getOutputStream().flush();
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating bill: " + e.getMessage());
        }
    }
}