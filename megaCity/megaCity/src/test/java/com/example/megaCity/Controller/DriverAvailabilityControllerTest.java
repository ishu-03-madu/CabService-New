package com.example.megaCity.Controller;

import com.example.megaCity.Model.Driver;
import com.example.megaCity.Service.DriverService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.Model;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

public class DriverAvailabilityControllerTest {

    @Mock
    private DriverService driverService;

    @Mock
    private Model model;

    @InjectMocks
    private DriverController driverController;

    private MockMvc mockMvc;
    private Driver testDriver;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(driverController).build();

        // Create test driver
        testDriver = new Driver();
        testDriver.setDriverId("001");
        testDriver.setFirstName("John");
        testDriver.setSecondName("Doe");
        testDriver.setNic("123456789V");
        testDriver.setPhone("0711234567");
        testDriver.setAddress("Colombo");
        testDriver.setLicenseNo("B123456");
        testDriver.setAvailable(true);
    }

    @Test
    public void testDriverDetailsPage() {
        // Arrange
        List<Driver> drivers = Arrays.asList(testDriver);
        when(driverService.getAllDrivers()).thenReturn(drivers);

        // Act
        String viewName = driverController.driverDetailsPage(model);

        // Assert
        assertEquals("DriverDetails", viewName);
        verify(model, times(1)).addAttribute(eq("drivers"), eq(drivers));
        verify(model, times(1)).addAttribute(eq("driver"), any(Driver.class));
        verify(driverService, times(1)).getAllDrivers();
    }


    @Test
    public void testAddDriver() throws Exception {
        // Arrange
        when(driverService.saveDriver(any(Driver.class))).thenReturn(testDriver);

        // Act & Assert
        mockMvc.perform(post("/drivers/add")
                        .param("firstName", "John")
                        .param("secondName", "Doe")
                        .param("nic", "123456789V")
                        .param("phone", "0711234567")
                        .param("address", "Colombo")
                        .param("licenseNo", "B123456"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/DriverDetails"));

        verify(driverService, times(1)).saveDriver(any(Driver.class));
    }

    @Test
    public void testDriverAvailability() {
        // Create a driver that is available
        Driver availableDriver = new Driver();
        availableDriver.setDriverId("001");
        availableDriver.setFirstName("John");
        availableDriver.setAvailable(true);

        // Test that isAvailable() returns the correct value
        assertTrue(availableDriver.isAvailable());

        // Change availability
        availableDriver.setAvailable(false);

        // Verify the change worked
        assertFalse(availableDriver.isAvailable());
    }

    @Test
    public void testCalculateSalary() throws Exception {
        // This would fail because driverHistoryService is not mocked
        mockMvc.perform(get("/drivers/salary/calculate")
                        .param("driverId", "001")
                        .param("startDate", "2024-03-01")
                        .param("endDate", "2024-03-05"))
                .andExpect(status().isOk())
                .andExpect(content().string("5000.0"));
    }

    @Test
    public void testDeleteDriver() throws Exception {
        // Arrange
        doNothing().when(driverService).deleteDriver(anyString());

        // Act & Assert
        mockMvc.perform(get("/drivers/delete/001"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/DriverDetails"));

        verify(driverService, times(1)).deleteDriver("001");
    }

    @Test
    public void testGetDriverForEdit() throws Exception {
        // Arrange
        when(driverService.getDriverById("001")).thenReturn(Optional.of(testDriver));

        // Act & Assert
        mockMvc.perform(get("/drivers/edit/001"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.driverId").value("001"))
                .andExpect(jsonPath("$.firstName").value("John"))
                .andExpect(jsonPath("$.secondName").value("Doe"))
                .andExpect(jsonPath("$.nic").value("123456789V"))
                .andExpect(jsonPath("$.phone").value("0711234567"))
                .andExpect(jsonPath("$.address").value("Colombo"))
                .andExpect(jsonPath("$.licenseNo").value("B123456"));

        verify(driverService, times(1)).getDriverById("001");
    }

    @Test
    public void testGetDriverForEdit_NotFound() throws Exception {
        // Arrange
        when(driverService.getDriverById("999")).thenReturn(Optional.empty());

        // Act & Assert
        mockMvc.perform(get("/drivers/edit/999"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.driverId").doesNotExist());

        verify(driverService, times(1)).getDriverById("999");
    }

    @Test
    public void testUpdateDriver() throws Exception {
        // Arrange
        when(driverService.saveDriver(any(Driver.class))).thenReturn(testDriver);

        // Act & Assert
        mockMvc.perform(post("/drivers/update")
                        .param("driverId", "001")
                        .param("firstName", "John")
                        .param("secondName", "Doe")
                        .param("nic", "123456789V")
                        .param("phone", "0711234567")
                        .param("address", "Colombo")
                        .param("licenseNo", "B123456"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/DriverDetails"));

        verify(driverService, times(1)).saveDriver(any(Driver.class));
    }
}