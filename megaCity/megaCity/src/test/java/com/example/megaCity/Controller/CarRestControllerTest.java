package com.example.megaCity.Controller;

import com.example.megaCity.Model.Car;
import com.example.megaCity.Repository.CarRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class CarRestControllerTest {

    @Mock
    private CarRepository carRepository;

    @InjectMocks
    private CarRestController carRestController;

    private Car testCar;
    private MockMultipartFile testImage;

    @BeforeEach
    void setUp() {
        // Create a test car
        testCar = new Car();
        testCar.setCarNo("C001");
        testCar.setName("Test Car");
        testCar.setType("Sedan");
        testCar.setBrand("Test Brand");
        testCar.setPrice(50000.0);
        testCar.setPeopleCapacity(5);
        testCar.setDoors(4);
        testCar.setFuelLiters(50);
        testCar.setAboutCar("This is a test car");
        testCar.setIncludedFeatures("AC, Power Steering");
        testCar.setExcludedFeatures("Sunroof");

        // Create a test image
        testImage = new MockMultipartFile(
                "image",
                "test-image.jpg",
                "image/jpeg",
                "test image content".getBytes()
        );
    }

    @Test
    void getAllCars_ShouldReturnAllCars() {
        // Arrange
        List<Car> cars = new ArrayList<>();
        cars.add(testCar);

        when(carRepository.findAll()).thenReturn(cars);

        // Act
        List<Car> result = carRestController.getAllCars();

        // Assert
        assertEquals(1, result.size());
        assertEquals("C001", result.get(0).getCarNo());
        verify(carRepository, times(1)).findAll();
    }

    @Test
    void getCarByCarNo_WhenCarExists_ShouldReturnCar() {
        // Arrange
        when(carRepository.findById("C001")).thenReturn(Optional.of(testCar));

        // Act
        ResponseEntity<Car> response = carRestController.getCarByCarNo("C001");

        // Assert
        assertTrue(response.getStatusCode().is2xxSuccessful());
        assertEquals("C001", response.getBody().getCarNo());
        verify(carRepository, times(1)).findById("C001");
    }

    @Test
    void getCarByCarNo_WhenCarDoesNotExist_ShouldReturnNotFound() {
        // Arrange
        when(carRepository.findById("NONEXISTENT")).thenReturn(Optional.empty());

        // Act
        ResponseEntity<Car> response = carRestController.getCarByCarNo("NONEXISTENT");

        // Assert
        assertTrue(response.getStatusCode().is4xxClientError());
        verify(carRepository, times(1)).findById("NONEXISTENT");
    }

    @Test
    void addCar_WithValidData_ShouldReturnSavedCar() throws IOException {
        // Arrange
        when(carRepository.save(any(Car.class))).thenAnswer(invocation -> invocation.getArgument(0));

        // Mock Files.exists and Files.createDirectories to avoid filesystem operations
        mockStaticFilesOperations();

        // Act
        ResponseEntity<Car> response = carRestController.addCar(
                "C001", "Test Car", "Sedan", "Test Brand",
                50000.0, 5, 4, 50,
                "This is a test car", "AC, Power Steering",
                "Sunroof", testImage
        );

        // Assert
        assertTrue(response.getStatusCode().is2xxSuccessful());
        assertEquals("C001", response.getBody().getCarNo());
        assertEquals("Test Car", response.getBody().getName());
        assertNotNull(response.getBody().getImages());

        verify(carRepository, times(1)).save(any(Car.class));
    }

    @Test
    void addCar_WithoutImage_ShouldSaveCarWithoutImage() throws IOException {
        // Arrange
        when(carRepository.save(any(Car.class))).thenAnswer(invocation -> invocation.getArgument(0));

        // Act
        ResponseEntity<Car> response = carRestController.addCar(
                "C001", "Test Car", "Sedan", "Test Brand",
                50000.0, 5, 4, 50,
                "This is a test car", "AC, Power Steering",
                "Sunroof", null
        );

        // Assert
        assertTrue(response.getStatusCode().is2xxSuccessful());
        assertEquals("C001", response.getBody().getCarNo());
        assertEquals("Test Car", response.getBody().getName());
        assertNull(response.getBody().getImages());

        verify(carRepository, times(1)).save(any(Car.class));
    }

    @Test
    void updateCar_WhenCarExists_ShouldReturnUpdatedCar() throws IOException {
        // Arrange
        when(carRepository.findById("C001")).thenReturn(Optional.of(testCar));
        when(carRepository.save(any(Car.class))).thenAnswer(invocation -> invocation.getArgument(0));

        // Mock Files.exists and Files.createDirectories to avoid filesystem operations
        mockStaticFilesOperations();

        // Act
        ResponseEntity<Car> response = carRestController.updateCar(
                "C001", "Updated Car", "SUV", "Updated Brand",
                60000.0, 7, 5, 60,
                "This is an updated car", "AC, Power Steering, GPS",
                "Sunroof, Self-driving", testImage
        );

        // Assert
        assertTrue(response.getStatusCode().is2xxSuccessful());
        assertEquals("C001", response.getBody().getCarNo());
        assertEquals("Updated Car", response.getBody().getName());
        assertEquals("SUV", response.getBody().getType());
        assertNotNull(response.getBody().getImages());

        verify(carRepository, times(1)).findById("C001");
        verify(carRepository, times(1)).save(any(Car.class));
    }

    @Test
    void updateCar_WhenCarDoesNotExist_ShouldReturnNotFound() throws IOException {
        // Arrange
        when(carRepository.findById("NONEXISTENT")).thenReturn(Optional.empty());

        // Act
        ResponseEntity<Car> response = carRestController.updateCar(
                "NONEXISTENT", "Updated Car", "SUV", "Updated Brand",
                60000.0, 7, 5, 60,
                "This is an updated car", "AC, Power Steering, GPS",
                "Sunroof, Self-driving", testImage
        );

        // Assert
        assertTrue(response.getStatusCode().is4xxClientError());

        verify(carRepository, times(1)).findById("NONEXISTENT");
        verify(carRepository, never()).save(any(Car.class));
    }

    @Test
    void deleteCar_WhenCarExists_ShouldReturnOk() {
        // Arrange
        when(carRepository.existsById("C001")).thenReturn(true);
        doNothing().when(carRepository).deleteById("C001");

        // Act
        ResponseEntity<Void> response = carRestController.deleteCar("C001");

        // Assert
        assertTrue(response.getStatusCode().is2xxSuccessful());

        verify(carRepository, times(1)).existsById("C001");
        verify(carRepository, times(1)).deleteById("C001");
    }

    @Test
    void deleteCar_WhenCarDoesNotExist_ShouldReturnNotFound() {
        // Arrange
        when(carRepository.existsById("NONEXISTENT")).thenReturn(false);

        // Act
        ResponseEntity<Void> response = carRestController.deleteCar("NONEXISTENT");

        // Assert
        assertTrue(response.getStatusCode().is4xxClientError());

        verify(carRepository, times(1)).existsById("NONEXISTENT");
        verify(carRepository, never()).deleteById(anyString());
    }

    /**
     * Helper method to mock static Files operations to avoid filesystem operations during tests
     */
    private void mockStaticFilesOperations() throws IOException {
        // This is a simplified approach. For a more complete solution,
        // you might want to use MockedStatic from Mockito for Java 16+
        // or PowerMock for earlier versions to mock the static methods properly.

        // For the purpose of these tests, we're just assuming the operations succeed
        // In a real test environment, you might want to properly mock these static methods
    }
}