<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        .booking-card {
            margin-bottom: 20px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .booking-header {
            padding: 15px;
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }
        .booking-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .status-pending {
            background-color: #ffeeba;
            color: #856404;
        }
        .status-confirmed {
            background-color: #d4edda;
            color: #155724;
        }
        .status-completed {
            background-color: #c3e6cb;
            color: #1e7e34;
        }
        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
        .booking-body {
            padding: 20px;
        }
        .booking-actions {
            padding: 15px;
            background-color: #f8f9fa;
            border-top: 1px solid #dee2e6;
            text-align: right;
        }
        .no-bookings {
            text-align: center;
            padding: 50px 20px;
            background-color: #f8f9fa;
            border-radius: 10px;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar - Include your site navigation here -->
    <div class="navbar">
        <!-- Your navigation code here -->
    </div>

    <div class="container mt-5 mb-5">
        <h1 class="mb-4">My Bookings</h1>

        <!-- Alert Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Bookings List -->
        <c:choose>
            <c:when test="${empty bookings}">
                <div class="no-bookings">
                    <i class="fa-solid fa-calendar-xmark mb-3" style="font-size: 50px; color: #6c757d;"></i>
                    <h3>No Bookings Found</h3>
                    <p>You haven't made any car rental bookings yet.</p>
                    <a href="${pageContext.request.contextPath}/carDisplay" class="btn btn-primary mt-3">
                        Browse Cars
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="booking" items="${bookings}">
                    <div class="booking-card">
                        <div class="booking-header d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="mb-0">Booking #${booking.bookingNo}</h5>
                                <small class="text-muted">
                                    <fmt:formatDate value="${booking.createdAt}" pattern="MMM dd, yyyy HH:mm" />
                                </small>
                            </div>
                            <div class="booking-status status-${booking.status.toLowerCase()}">
                                ${booking.status}
                            </div>
                        </div>
                        <div class="booking-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Car:</strong> ${car.name} (${car.brand})</p>
                                    <p><strong>Dates:</strong>
                                        <fmt:formatDate value="${booking.startDate}" pattern="MMM dd, yyyy" /> to
                                        <fmt:formatDate value="${booking.endDate}" pattern="MMM dd, yyyy" />
                                    </p>
                                    <p><strong>With Driver:</strong> ${booking.withDriver ? 'Yes' : 'No'}</p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Total Amount:</strong> Rs. ${booking.totalAmount}</p>
                                    <c:if test="${booking.status == 'CONFIRMED' && booking.withDriver && not empty booking.driverId}">
                                        <p><strong>Driver:</strong> ${driver.firstName} ${driver.lastName}</p>
                                        <p><strong>Driver Contact:</strong> ${driver.contactNumber}</p>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="booking-actions">
                            <!-- Download Bill Button -->
                            <a href="${pageContext.request.contextPath}/download-bill/${booking.bookingNo}" class="btn btn-outline-primary btn-sm">
                                <i class="fa-solid fa-file-pdf"></i> Download Bill
                            </a>

                            <!-- Final Bill (if confirmed) -->
                            <c:if test="${booking.status == 'CONFIRMED' || booking.status == 'COMPLETED'}">
                                <a href="${pageContext.request.contextPath}/download-bill/${booking.bookingNo}?finalBill=true" class="btn btn-outline-success btn-sm ms-2">
                                    <i class="fa-solid fa-file-invoice"></i> Download Final Bill
                                </a>
                            </c:if>

                            <!-- Cancel Button (only for pending or confirmed bookings) -->
                            <c:if test="${booking.status == 'PENDING' || booking.status == 'CONFIRMED'}">
                                <a href="#" class="btn btn-outline-danger btn-sm ms-2" data-bs-toggle="modal" data-bs-target="#cancelModal${booking.id}">
                                    <i class="fa-solid fa-ban"></i> Cancel Booking
                                </a>

                                <!-- Cancel Confirmation Modal -->
                                <div class="modal fade" id="cancelModal${booking.id}" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Confirm Cancellation</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p>Are you sure you want to cancel this booking?</p>
                                                <p><strong>Booking:</strong> #${booking.bookingNo}</p>
                                                <p><strong>Dates:</strong>
                                                    <fmt:formatDate value="${booking.startDate}" pattern="MMM dd, yyyy" /> to
                                                    <fmt:formatDate value="${booking.endDate}" pattern="MMM dd, yyyy" />
                                                </p>
                                                <p class="text-danger">This action cannot be undone.</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                <a href="${pageContext.request.contextPath}/cancel-booking/${booking.bookingNo}" class="btn btn-danger">
                                                    Cancel Booking
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                <i class="fa-solid fa-home me-2"></i> Back to Home
            </a>
        </div>
    </div>

    <!-- Footer - Include your site footer here -->
    <footer class="footer">
        <!-- Your footer code here -->
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>