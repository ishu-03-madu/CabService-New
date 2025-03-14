package com.example.megaCity.Service;

import com.example.megaCity.Model.Driver;
import com.example.megaCity.Repository.DriverRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

public class DriverServiceTest {

    @Mock
    private DriverRepository driverRepository;

    @InjectMocks
    private DriverService driverService;

    private Driver testDriver;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);

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
    public void testGetAllDrivers() {
        // Arrange
        List<Driver> drivers = Arrays.asList(testDriver);
        when(driverRepository.findAll()).thenReturn(drivers);

        // Act
        List<Driver> result = driverService.getAllDrivers();

        // Assert
        assertEquals(1, result.size());
        assertEquals("John", result.get(0).getFirstName());
        verify(driverRepository, times(1)).findAll();
    }

    @Test
    public void testGetDriverById() {
        // Arrange
        when(driverRepository.findById("001")).thenReturn(Optional.of(testDriver));

        // Act
        Optional<Driver> result = driverService.getDriverById("001");

        // Assert
        assertTrue(result.isPresent());
        assertEquals("John", result.get().getFirstName());
        verify(driverRepository, times(1)).findById("001");
    }

    @Test
    public void testGetDriverByIdNotFound() {
        // Arrange
        when(driverRepository.findById("999")).thenReturn(Optional.empty());

        // Act
        Optional<Driver> result = driverService.getDriverById("999");

        // Assert
        assertFalse(result.isPresent());
        verify(driverRepository, times(1)).findById("999");
    }

    @Test
    public void testSaveDriver_New() {
        // Arrange
        Driver newDriver = new Driver();
        newDriver.setFirstName("Jane");
        newDriver.setSecondName("Smith");
        newDriver.setNic("987654321V");

        // Mock repository count and save
        when(driverRepository.count()).thenReturn(1L);
        when(driverRepository.save(any(Driver.class))).thenAnswer(invocation -> {
            Driver savedDriver = invocation.getArgument(0);
            return savedDriver;
        });

        // Act
        Driver result = driverService.saveDriver(newDriver);

        // Assert
        assertEquals("002", result.getDriverId()); // Should generate ID as 002
        assertEquals("Jane", result.getFirstName());
        verify(driverRepository, times(1)).count();
        verify(driverRepository, times(1)).save(any(Driver.class));
    }

    @Test
    public void testSaveDriver_Existing() {
        // Arrange
        when(driverRepository.save(testDriver)).thenReturn(testDriver);

        // Act
        Driver result = driverService.saveDriver(testDriver);

        // Assert
        assertEquals("001", result.getDriverId());
        assertEquals("John", result.getFirstName());
        verify(driverRepository, times(1)).save(testDriver);
        verify(driverRepository, never()).count(); // Shouldn't call count for existing driver
    }

    @Test
    public void testDeleteDriver() {
        // Arrange
        doNothing().when(driverRepository).deleteById("001");

        // Act
        driverService.deleteDriver("001");

        // Assert
        verify(driverRepository, times(1)).deleteById("001");
    }

    @Test
    public void testGetAvailableDrivers() {
        // Arrange
        List<Driver> availableDrivers = Arrays.asList(testDriver);
        when(driverRepository.findByAvailableTrue()).thenReturn(availableDrivers);

        // Act
        List<Driver> result = driverService.getAvailableDrivers();

        // Assert
        assertEquals(1, result.size());
        assertEquals("John", result.get(0).getFirstName());
        verify(driverRepository, times(1)).findByAvailableTrue();
    }

    @Test
    public void testUpdateDriverAvailability_Success() {
        // Arrange
        when(driverRepository.findById("001")).thenReturn(Optional.of(testDriver));
        when(driverRepository.save(any(Driver.class))).thenAnswer(invocation -> {
            Driver savedDriver = invocation.getArgument(0);
            return savedDriver;
        });

        // Act
        Driver result = driverService.updateDriverAvailability("001", false, "BK-123");

        // Assert
        assertNotNull(result);
        assertFalse(result.isAvailable());
        assertEquals("BK-123", result.getCurrentBookingNo());
        verify(driverRepository, times(1)).findById("001");
        verify(driverRepository, times(1)).save(any(Driver.class));
    }

    @Test
    public void testUpdateDriverAvailability_NotFound() {
        // Arrange
        when(driverRepository.findById("999")).thenReturn(Optional.empty());

        // Act
        Driver result = driverService.updateDriverAvailability("999", false, "BK-123");

        // Assert
        assertNull(result);
        verify(driverRepository, times(1)).findById("999");
        verify(driverRepository, never()).save(any(Driver.class));
    }

    @Test
    public void testSearchDrivers_ByNic() {
        // Arrange
        List<Driver> nicResults = Arrays.asList(testDriver);
        List<Driver> nameResults = Arrays.asList();
        when(driverRepository.findByNicContaining("123")).thenReturn(nicResults);
        when(driverRepository.findByFirstNameContaining("123")).thenReturn(nameResults);

        // Act
        List<Driver> result = driverService.searchDrivers("123");

        // Assert
        assertEquals(1, result.size());
        assertEquals("123456789V", result.get(0).getNic());
        verify(driverRepository, times(1)).findByNicContaining("123");
        verify(driverRepository, times(1)).findByFirstNameContaining("123");
    }

    @Test
    public void testSearchDrivers_ByName() {
        // Arrange
        List<Driver> nicResults = Arrays.asList();
        List<Driver> nameResults = Arrays.asList(testDriver);
        when(driverRepository.findByNicContaining("John")).thenReturn(nicResults);
        when(driverRepository.findByFirstNameContaining("John")).thenReturn(nameResults);

        // Act
        List<Driver> result = driverService.searchDrivers("John");

        // Assert
        assertEquals(1, result.size());
        assertEquals("John", result.get(0).getFirstName());
        verify(driverRepository, times(1)).findByNicContaining("John");
        verify(driverRepository, times(1)).findByFirstNameContaining("John");
    }

    @Test
    public void testSearchDrivers_NothingFound() {
        // Arrange
        List<Driver> emptyList = Arrays.asList();
        when(driverRepository.findByNicContaining("xyz")).thenReturn(emptyList);
        when(driverRepository.findByFirstNameContaining("xyz")).thenReturn(emptyList);

        // Act
        List<Driver> result = driverService.searchDrivers("xyz");

        // Assert
        assertEquals(0, result.size());
        verify(driverRepository, times(1)).findByNicContaining("xyz");
        verify(driverRepository, times(1)).findByFirstNameContaining("xyz");
    }
}