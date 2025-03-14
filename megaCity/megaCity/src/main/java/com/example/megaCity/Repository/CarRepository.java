package com.example.megaCity.Repository;

import com.example.megaCity.Model.Car;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CarRepository extends JpaRepository<Car, String> {
}
