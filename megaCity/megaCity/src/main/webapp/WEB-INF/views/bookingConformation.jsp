<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        .booking-confirmation {
            max-width: 800px;
            margin: 0 auto;
            padding: 30px;
            background-color: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .confirmation-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .confirmation-header h1 {
            color: #28a745;
            font-size: 28px;
        }
        .confirmation-details {
            margin-bottom: 30px;
        }
        .confirmation-details h2 {
            font-size: 20px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 15px;
        }
        .detail-row {
            display: flex;
            margin-bottom: 10px;
        }
        .detail-label {
            font-weight: bold;
            width: 150px;
        }
        .detail-value {
            flex: 1;
        }
        .download-bill {
            text-align: center;
            margin-top: 30px;
        }
        .download-btn {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .download-btn:hover {
            background-color: #218838;
            text-decoration: none;
            color: white;
        }
        .back-to-home {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container mt-5 mb-5">
        <div class="booking-confirmation">
            <div class="confirmation-header">
                <i class="fa-solid fa-circle-check text-success mb-3" style="font-size: 60px;"></i>
                <h1>Booking Confirmed!</h1>
                <p>Your car rental booking has been successfully created.</p>
            </div>

            <div class="confirmation-details">
                <h2>Booking Details</h2>

                <div class="detail-row">
                    <div class="detail-label">Booking Number:</div>
                    <div class="detail-value">${booking.bookingNo}</div>
                </div>

                <div class="detail-row">
                    <div class="detail-label">Car:</div>
                    <div class="detail-value">
                        <c:if test="${not empty car}">${car.name} (${car.brand})</c:if>
                        <c:if test="${empty car}">Car details not available</c:if>
                    </div>
                </div>

                <div class="detail-row">
                    <div class="detail-label">Dates:</div>
                    <div class="detail-value">
                        <fmt:parseDate value="${booking.startDate}" pattern="yyyy-MM-dd" var="parsedStartDate" type="date" />
                        <fmt:parseDate value="${booking.endDate}" pattern="yyyy-MM-dd" var="parsedEndDate" type="date" />
                        <fmt:formatDate value="${parsedStartDate}" pattern="MMM dd, yyyy" /> to
                        <fmt:formatDate value="${parsedEndDate}" pattern="MMM dd, yyyy" />
                    </div>
                </div>

                <div class="detail-row">
                    <div class="detail-label">With Driver:</div>
                    <div class="detail-value">${booking.withDriver ? 'Yes' : 'No'}</div>
                </div>

                <div class="detail-row">
                    <div class="detail-label">Total Amount:</div>
                    <div class="detail-value">Rs. ${booking.totalAmount}</div>
                </div>

                <div class="detail-row">
                    <div class="detail-label">Status:</div>
                    <div class="detail-value">${booking.status}</div>
                </div>
            </div>

            <div class="alert alert-info" role="alert">
                <i class="fa-solid fa-info-circle me-2"></i>
                Your booking is currently pending confirmation. Our team will review it and confirm your booking shortly.
            </div>

            <div class="download-bill">
                <a href="${pageContext.request.contextPath}/download-bill/${booking.bookingNo}" class="download-btn">
                    <i class="fa-solid fa-file-pdf me-2"></i> Download Provisional Bill
                </a>
            </div>

            <div class="back-to-home mt-4 text-center">
                <a href="${pageContext.request.contextPath}/my-bookings" class="btn btn-outline-primary">
                    <i class="fa-solid fa-list me-2"></i> View My Bookings
                </a>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary ms-2">
                    <i class="fa-solid fa-home me-2"></i> Back to Home
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>