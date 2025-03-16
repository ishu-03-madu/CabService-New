package com.example.megaCity.Model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "bookings")
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String bookingNo;

    @Column(nullable = false)
    private String carNo;

    @Column(nullable = false)
    private Long userId;

    // Added customer identification field
    private String customerNic;

    @Column(nullable = false)
    private LocalDate startDate;

    @Column(nullable = false)
    private LocalDate endDate;

    // Added destination field
    private String destination;

    // Added start and end km fields
    private Double startKm;
    private Double endKm;

    private boolean withDriver;

    private String message;

    // Added driver cost field
    private Double driverCost;

    // Added payment fields
    private Double paidAmount;
    private String paymentStatus; // "Online Payment Done", "Cash Payment", "Cash Payment Done"

    // Added extra charges fields
    private Double extraCharges;
    private String extraChargesStatus; // "Pending", "Done", "No Charges"

    // Added refundable amount fields
    private Double refundableAmount;
    private String refundableStatus; // "Pending", "Refundable Done", "No Refund"

    private double totalAmount;

    @Column(nullable = false)
    private String status; // "PENDING", "CONFIRMED", "CANCELLED", "COMPLETED"

    private LocalDateTime createdAt;

    private LocalDateTime confirmationDate;

    private String driverId;

    private String billUrl;

    private String finalBillUrl;

    // Constructors, getters, and setters
    public Booking() {
        this.createdAt = LocalDateTime.now();
        this.status = "PENDING";
        this.paymentStatus = "Pending";
        this.extraChargesStatus = "No Charges";
        this.refundableStatus = "No Refund";
        this.extraCharges = 0.0;
        this.refundableAmount = 0.0;
        this.driverCost = 0.0;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getBookingNo() {
        return bookingNo;
    }

    public void setBookingNo(String bookingNo) {
        this.bookingNo = bookingNo;
    }

    public String getCarNo() {
        return carNo;
    }

    public void setCarNo(String carNo) {
        this.carNo = carNo;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getCustomerNic() {
        return customerNic;
    }

    public void setCustomerNic(String customerNic) {
        this.customerNic = customerNic;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public Double getStartKm() {
        return startKm;
    }

    public void setStartKm(Double startKm) {
        this.startKm = startKm;
    }

    public Double getEndKm() {
        return endKm;
    }

    public void setEndKm(Double endKm) {
        this.endKm = endKm;
    }

    public boolean isWithDriver() {
        return withDriver;
    }

    public void setWithDriver(boolean withDriver) {
        this.withDriver = withDriver;
    }

    public Double getDriverCost() {
        return driverCost;
    }

    public void setDriverCost(Double driverCost) {
        this.driverCost = driverCost;
    }

    public Double getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(Double paidAmount) {
        this.paidAmount = paidAmount;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Double getExtraCharges() {
        return extraCharges;
    }

    public void setExtraCharges(Double extraCharges) {
        this.extraCharges = extraCharges;
    }

    public String getExtraChargesStatus() {
        return extraChargesStatus;
    }

    public void setExtraChargesStatus(String extraChargesStatus) {
        this.extraChargesStatus = extraChargesStatus;
    }

    public Double getRefundableAmount() {
        return refundableAmount;
    }

    public void setRefundableAmount(Double refundableAmount) {
        this.refundableAmount = refundableAmount;
    }

    public String getRefundableStatus() {
        return refundableStatus;
    }

    public void setRefundableStatus(String refundableStatus) {
        this.refundableStatus = refundableStatus;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getConfirmationDate() {
        return confirmationDate;
    }

    public void setConfirmationDate(LocalDateTime confirmationDate) {
        this.confirmationDate = confirmationDate;
    }

    public String getDriverId() {
        return driverId;
    }

    public void setDriverId(String driverId) {
        this.driverId = driverId;
    }

    public String getBillUrl() {
        return billUrl;
    }

    public void setBillUrl(String billUrl) {
        this.billUrl = billUrl;
    }

    public String getFinalBillUrl() {
        return finalBillUrl;
    }

    public void setFinalBillUrl(String finalBillUrl) {
        this.finalBillUrl = finalBillUrl;
    }

    // Calculate total bill based on all charges
    public Double calculateTotalBill() {
        Double total = this.totalAmount;

        if (this.driverCost != null) {
            total += this.driverCost;
        }

        if (this.extraCharges != null) {
            total += this.extraCharges;
        }

        if (this.refundableAmount != null) {
            total -= this.refundableAmount;
        }

        return total;
    }
}