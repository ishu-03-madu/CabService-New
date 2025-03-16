package com.example.megaCity.Util;

import com.example.megaCity.Model.Booking;
import com.example.megaCity.Model.Car;
import com.example.megaCity.Model.User;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

/**
 * A placeholder class for PDF generation
 * In a real application, you would use a library like iText PDF
 */
public class PdfGeneratorPlaceholder {

    private static final String BILL_DIR = "./bills";

    /**
     * Generate a simple text file that simulates a PDF bill
     * @param booking The booking to generate a bill for
     * @param user The user who made the booking
     * @param car The car that was booked
     * @param isFinal Whether this is a final bill or a provisional bill
     * @return The file name of the generated bill
     */
    public static String generateBill(Booking booking, User user, Car car, boolean isFinal) throws IOException {
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

        // Create a simple text file as placeholder - in production you'd use a PDF library
        File file = new File(filePath);
        try (FileOutputStream fos = new FileOutputStream(file)) {
            StringBuilder content = new StringBuilder();
            content.append("MEGA CITY CAB - ").append(isFinal ? "FINAL" : "PROVISIONAL").append(" RECEIPT\n\n");
            content.append("Booking No: ").append(booking.getBookingNo()).append("\n");
            content.append("Date: ").append(LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm"))).append("\n\n");

            // Add customer details
            if (user != null) {
                content.append("Customer: ").append(user.getFirstName()).append(" ").append(user.getLastName()).append("\n");
                content.append("Email: ").append(user.getEmail()).append("\n\n");
            }

            // Add car details
            if (car != null) {
                content.append("Car: ").append(car.getName()).append(" (").append(car.getBrand()).append(")\n");
                content.append("Car No: ").append(car.getCarNo()).append("\n\n");
            }

            // Add booking details
            content.append("Start Date: ").append(booking.getStartDate().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))).append("\n");
            content.append("End Date: ").append(booking.getEndDate().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))).append("\n");
            content.append("With Driver: ").append(booking.isWithDriver() ? "Yes" : "No").append("\n\n");

            // Add cost details
            long days = ChronoUnit.DAYS.between(booking.getStartDate(), booking.getEndDate()) + 1;
            double carCost = car != null ? car.getPrice() * days : 0;
            double driverCost = booking.isWithDriver() ? (carCost * 0.25) : 0;

            content.append("Car Rental: Rs. ").append(String.format("%.2f", carCost)).append("\n");
            if (booking.isWithDriver()) {
                content.append("Driver Fee: Rs. ").append(String.format("%.2f", driverCost)).append("\n");
            }
            content.append("Total Amount: Rs. ").append(String.format("%.2f", booking.getTotalAmount())).append("\n\n");

            content.append("Status: ").append(isFinal ? "CONFIRMED" : booking.getStatus()).append("\n\n");
            content.append("Thank you for choosing Mega City Cab!");

            // Write content to file
            fos.write(content.toString().getBytes());
        }

        return fileName;
    }
}