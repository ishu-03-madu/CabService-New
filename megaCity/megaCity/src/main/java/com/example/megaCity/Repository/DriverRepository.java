package com.example.megaCity.Repository;
import com.example.megaCity.Model.Driver;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DriverRepository extends JpaRepository<Driver, String> {
    // Find by NIC for search functionality
    List<Driver> findByNicContaining(String nic);

    // Find available drivers
    List<Driver> findByAvailableTrue();

    // Find by first name for search functionality
    List<Driver> findByFirstNameContaining(String firstName);
}