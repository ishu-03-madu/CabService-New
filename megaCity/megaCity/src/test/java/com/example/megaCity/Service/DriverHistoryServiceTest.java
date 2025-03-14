package com.example.megaCity.Service;

import com.example.megaCity.Model.DriverHistory;
import com.example.megaCity.Repository.DriverHistoryRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

public class DriverHistoryServiceTest {

    @Mock
    private DriverHistoryRepository driverHistoryRepository;

    @InjectMocks
    private DriverHistoryService driverHistoryService;

    private DriverHistory testHistory;
    private LocalDate startDate;
    private LocalDate endDate;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);

        // Set up test dates
        startDate = LocalDate.of(2024, 3, 1);
        endDate = LocalDate.of(2024, 3, 5);

        // Create test driver history
        testHistory = new DriverHistory();
        testHistory.setId(1L);
        testHistory.setDriverId("001");
        testHistory.setNic("123456789V");
        testHistory.setFirstName("John");
        testHistory.setBookingId("BK-123");
        testHistory.setStartDate(startDate);
        testHistory.setEndDate(endDate);
        testHistory.setRideAmount(5000.0);
    }

    @Test
    public void testGetAllDriverHistory() {
        // Arrange
        List<DriverHistory> histories = Arrays.asList(testHistory);
        when(driverHistoryRepository.findAll()).thenReturn(histories);

        // Act
        List<DriverHistory> result = driverHistoryService.getAllDriverHistory();

        // Assert
        assertEquals(1, result.size());
        assertEquals("001", result.get(0).getDriverId());
        verify(driverHistoryRepository, times(1)).findAll();
    }

    @Test
    public void testGetDriverHistoryById() {
        // Arrange
        when(driverHistoryRepository.findById(1L)).thenReturn(Optional.of(testHistory));

        // Act
        Optional<DriverHistory> result = driverHistoryService.getDriverHistoryById(1L);

        // Assert
        assertTrue(result.isPresent());
        assertEquals("001", result.get().getDriverId());
        verify(driverHistoryRepository, times(1)).findById(1L);
    }

    @Test
    public void testGetDriverHistoryById_NotFound() {
        // Arrange
        when(driverHistoryRepository.findById(999L)).thenReturn(Optional.empty());

        // Act
        Optional<DriverHistory> result = driverHistoryService.getDriverHistoryById(999L);

        // Assert
        assertFalse(result.isPresent());
        verify(driverHistoryRepository, times(1)).findById(999L);
    }

    @Test
    public void testGetDriverHistoryByDriverId() {
        // Arrange
        List<DriverHistory> histories = Arrays.asList(testHistory);
        when(driverHistoryRepository.findByDriverId("001")).thenReturn(histories);

        // Act
        List<DriverHistory> result = driverHistoryService.getDriverHistoryByDriverId("001");

        // Assert
        assertEquals(1, result.size());
        assertEquals("John", result.get(0).getFirstName());
        verify(driverHistoryRepository, times(1)).findByDriverId("001");
    }

    @Test
    public void testSaveDriverHistory() {
        // Arrange
        DriverHistory newHistory = new DriverHistory();
        newHistory.setDriverId("002");
        newHistory.setNic("987654321V");

        when(driverHistoryRepository.save(any(DriverHistory.class))).thenAnswer(invocation -> {
            DriverHistory savedHistory = invocation.getArgument(0);
            return savedHistory;
        });

        // Act
        DriverHistory result = driverHistoryService.saveDriverHistory(newHistory);

        // Assert
        assertEquals("002", result.getDriverId());
        verify(driverHistoryRepository, times(1)).save(any(DriverHistory.class));
    }

    @Test
    public void testDeleteDriverHistory() {
        // Arrange
        doNothing().when(driverHistoryRepository).deleteById(1L);

        // Act
        driverHistoryService.deleteDriverHistory(1L);

        // Assert
        verify(driverHistoryRepository, times(1)).deleteById(1L);
    }

    @Test
    public void testSearchDriverHistoryByNic() {
        // Arrange
        List<DriverHistory> histories = Arrays.asList(testHistory);
        when(driverHistoryRepository.findByNicContaining("123")).thenReturn(histories);

        // Act
        List<DriverHistory> result = driverHistoryService.searchDriverHistoryByNic("123");

        // Assert
        assertEquals(1, result.size());
        assertEquals("123456789V", result.get(0).getNic());
        verify(driverHistoryRepository, times(1)).findByNicContaining("123");
    }

    @Test
    public void testGetDriverHistoryByDateRange() {
        // Arrange
        List<DriverHistory> histories = Arrays.asList(testHistory);
        when(driverHistoryRepository.findByStartDateGreaterThanEqualAndEndDateLessThanEqual(
                startDate, endDate)).thenReturn(histories);

        // Act
        List<DriverHistory> result = driverHistoryService.getDriverHistoryByDateRange(startDate, endDate);

        // Assert
        assertEquals(1, result.size());
        assertEquals("BK-123", result.get(0).getBookingId());
        verify(driverHistoryRepository, times(1))
                .findByStartDateGreaterThanEqualAndEndDateLessThanEqual(startDate, endDate);
    }

    @Test
    public void testCalculateTotalSalary_WithRecords() {
        // Arrange
        Double expectedSalary = 5000.0;
        when(driverHistoryRepository.calculateTotalSalary("001", startDate, endDate)).thenReturn(expectedSalary);

        // Act
        Double result = driverHistoryService.calculateTotalSalary("001", startDate, endDate);

        // Assert
        assertEquals(expectedSalary, result);
        verify(driverHistoryRepository, times(1)).calculateTotalSalary("001", startDate, endDate);
    }

    @Test
    public void testCalculateTotalSalary_NoRecords() {
        // Arrange
        when(driverHistoryRepository.calculateTotalSalary("001", startDate, endDate)).thenReturn(null);

        // Act
        Double result = driverHistoryService.calculateTotalSalary("001", startDate, endDate);

        // Assert
        assertEquals(0.0, result);
        verify(driverHistoryRepository, times(1)).calculateTotalSalary("001", startDate, endDate);
    }
}