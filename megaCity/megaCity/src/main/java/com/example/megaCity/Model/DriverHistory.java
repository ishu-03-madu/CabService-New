package com.example.megaCity.Model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.util.Date;
import java.util.Objects;

@Entity
@Table(name = "driver_history")
public class DriverHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String driverId;
    private String nic;
    private String firstName;
    private String bookingId;
    private Date startDate;  // Changed to Date
    private Date endDate;    // Changed to Date
    private double rideAmount;

    public DriverHistory() {
    }

    public DriverHistory(String driverId, String nic, String firstName, String bookingId,
                         Date startDate, Date endDate, double rideAmount) {
        this.driverId = driverId;
        this.nic = nic;
        this.firstName = firstName;
        this.bookingId = bookingId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.rideAmount = rideAmount;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDriverId() {
        return driverId;
    }

    public void setDriverId(String driverId) {
        this.driverId = driverId;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public double getRideAmount() {
        return rideAmount;
    }

    public void setRideAmount(double rideAmount) {
        this.rideAmount = rideAmount;
    }

    @Override
    public String toString() {
        return "DriverHistory{" +
                "id=" + id +
                ", driverId='" + driverId + '\'' +
                ", nic='" + nic + '\'' +
                ", firstName='" + firstName + '\'' +
                ", bookingId='" + bookingId + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", rideAmount=" + rideAmount +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DriverHistory that = (DriverHistory) o;
        return Double.compare(that.rideAmount, rideAmount) == 0 &&
                Objects.equals(id, that.id) &&
                Objects.equals(driverId, that.driverId) &&
                Objects.equals(nic, that.nic) &&
                Objects.equals(firstName, that.firstName) &&
                Objects.equals(bookingId, that.bookingId) &&
                Objects.equals(startDate, that.startDate) &&
                Objects.equals(endDate, that.endDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, driverId, nic, firstName, bookingId, startDate, endDate, rideAmount);
    }
}