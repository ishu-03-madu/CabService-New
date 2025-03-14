package com.example.megaCity.Model;



import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Car {
    @Id
    private String carNo;
    private String name;
    private String type;
    private String brand;
    private double price;
    private int peopleCapacity;
    private int doors;
    private int fuelLiters;
    private String aboutCar;
    private String includedFeatures; // Comma-separated string
    private String excludedFeatures; // Comma-separated string
    private String images; // Comma-separated image filenames

    // Default constructor (required by JPA)
    public Car() {
    }

    // Getters and Setters
    public String getCarNo() {
        return carNo;
    }

    public void setCarNo(String carNo) {
        this.carNo = carNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getPeopleCapacity() {
        return peopleCapacity;
    }

    public void setPeopleCapacity(int peopleCapacity) {
        this.peopleCapacity = peopleCapacity;
    }

    public int getDoors() {
        return doors;
    }

    public void setDoors(int doors) {
        this.doors = doors;
    }

    public int getFuelLiters() {
        return fuelLiters;
    }

    public void setFuelLiters(int fuelLiters) {
        this.fuelLiters = fuelLiters;
    }

    public String getAboutCar() {
        return aboutCar;
    }

    public void setAboutCar(String aboutCar) {
        this.aboutCar = aboutCar;
    }

    public String getIncludedFeatures() {
        return includedFeatures;
    }

    public void setIncludedFeatures(String includedFeatures) {
        this.includedFeatures = includedFeatures;
    }

    public String getExcludedFeatures() {
        return excludedFeatures;
    }

    public void setExcludedFeatures(String excludedFeatures) {
        this.excludedFeatures = excludedFeatures;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }
}