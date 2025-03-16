<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Booking Data</title>
    <style>
        /* Basic styling for layout */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #2c2b2b;
        }

        .dashboard {
            display: flex;
        }

        .sidebar {
            height: 100vh;
            width: 300px;
            background-color: #2c2b2b;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        /* Logo Styles */
        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 25px;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
        }

        .logo-link{
            text-decoration: none;
            cursor: pointer;
            color: #ff4d4d;
            text-shadow: 4px 4px 8px rgba(0, 0, 0, 0.5);
            font-size: 24px;
            font-weight: bold;
            font-family: cursive;
            font-style: italic;
            text-transform: uppercase;
        }

        /* Menu Styles */
        .menu {
            margin-top: 30px;
        }

        .menu ul {
            list-style: none;
        }

        .menu-item {
            padding: 15px 20px;
            cursor: pointer;
            display: flex;
            align-items: center;
            transition: background-color 0.3s ease;
            font-size: 1.1rem;
        }

        .menu-item:hover, .menu-item.active {
            background-color: rgb(65, 64, 64);
        }

        .menu-item a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            width: 100%;
        }

        .submenu {
            list-style-type: none;
            padding-left: 20px;
            display: none;
        }

        .menu-item:hover + .submenu,
        .submenu:hover {
            display: block;
        }

        .icon {
            margin-right: 15px;
            font-size: 1.2rem;
        }

        /* Logout Button */
        .logout {
            padding: 15px 20px;
            cursor: pointer;
            display: flex;
            align-items: center;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
            transition: background-color 0.3s ease;
        }

        .logout:hover {
            background-color: rgb(65, 64, 64);
        }

        .rightside {
            flex: 1;
            padding: 20px;
            background-color: #f5f5f5;
            border-top-left-radius: 20px;
            border-bottom-left-radius: 20px;
            min-height: 100vh;
            overflow-y: auto;
        }

        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .buttons {
            margin-top: 20px;
        }

        button {
            padding: 8px 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }

        .view-btn {
            background-color: #2196F3;
        }

        .edit-btn {
            background-color: #2196F3;
            padding: 5px 10px;
            margin: 2px;
        }

        .remove-btn {
            background-color: #f44336;
            padding: 5px 10px;
            margin: 2px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        table th {
            background-color: #333;
            color: white;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .search-container {
            margin-bottom: 20px;
        }

        .search-container input {
            padding: 8px;
            width: 70%;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .search-container button {
            padding: 8px 16px;
        }

        .alert {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
        }

        .alert-success {
            background-color: #dff0d8;
            color: #3c763d;
        }

        .alert-danger {
            background-color: #f2dede;
            color: #a94442;
        }
    </style>
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <!-- Logo Section -->
            <div class="logo">
                <img src="${pageContext.request.contextPath}/images/logo.png" class="logo-icon">
                <a href="${pageContext.request.contextPath}/dashboard" class="logo-link">Mega City Cab</a>
            </div>

            <!-- Navigation Menu -->
            <nav class="menu">
                <ul>
                    <li class="menu-item">
                        <a href="${pageContext.request.contextPath}/dashboard">
                            <span class="icon">🏠</span> Dashboard
                        </a>
                    </li>
                    <li class="menu-item">
                        <a href="${pageContext.request.contextPath}/carDetails">
                            <span class="icon">📅</span> Car Availability
                        </a>
                    </li>
                    <li class="menu-item active">
                        <a href="${pageContext.request.contextPath}/booking-confirmation">
                            <span class="icon">📖</span> Bookings
                        </a>
                    </li>

                    <!-- Pages Section with Toggle -->
                    <li class="menu-item" onclick="toggleSubmenu()">
                        <span class="icon">📄</span> Pages ▼
                    </li>
                    <ul class="submenu" id="pagesSubmenu">
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/carDetails">Cars</a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/DriverDetails">Driver Details</a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/DriverAvailability">Driver Availability</a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/Aboutpage">About</a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/Contactpage">Contact</a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/Homecarousel">Home Carousel</a>
                        </li>
                    </ul>

                    <li class="menu-item">
                        <a href="${pageContext.request.contextPath}/UserDetails">
                            <span class="icon">👤</span> Users
                        </a>
                    </li>

                    <li class="menu-item">
                        <a href="${pageContext.request.contextPath}/Messages">
                            <span class="icon">💬</span> Feedback & Messages
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Logout Button -->
            <div class="logout" onclick="location.href='${pageContext.request.contextPath}/logout'">
                <span class="icon">🚪</span> Logout
            </div>
        </div>

        <div class="rightside">
            <div class="container">
                <h2>Update Booking Data</h2>
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">${successMessage}</div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">${errorMessage}</div>
                </c:if>

                <div class="search-container">
                    <form action="${pageContext.request.contextPath}/bookings/search" method="GET">
                        <input type="text" id="searchInput" name="query" placeholder="Search by Booking No or Customer NIC">
                        <button type="submit" id="searchButton">Search</button>
                    </form>
                </div>

                <form id="updateBookingForm" action="${pageContext.request.contextPath}/bookings/update" method="POST">
                    <div class="form-group">
                        <label>Booking No:</label>
                        <input type="text" id="bookingNo" name="bookingNo" value="${booking.bookingNo}" readonly>
                    </div>
                    <div class="form-group">
                        <label>Car No:</label>
                        <input type="text" id="carNo" name="carNo" value="${booking.carNo}">
                    </div>
                    <div class="form-group">
                        <label>Customer NIC/Passport:</label>
                        <input type="text" id="customerNic" name="customerNic" value="${booking.customerNic}">
                    </div>
                    <div class="form-group">
                        <label>Start Date:</label>
                        <input type="date" id="startDate" name="startDate" value="${startDateStr}">
                    </div>
                    <div class="form-group">
                        <label>End Date:</label>
                        <input type="date" id="endDate" name="endDate" value="${endDateStr}">
                    </div>
                    <div class="form-group">
                        <label>Designated Destination:</label>
                        <input type="text" id="destination" name="destination" value="${booking.destination}">
                    </div>
                    <div class="form-group">
                        <label>Start KM:</label>
                        <input type="number" step="0.1" id="startKm" name="startKm" value="${booking.startKm}">
                    </div>
                    <div class="form-group">
                        <label>End KM:</label>
                        <input type="number" step="0.1" id="endKm" name="endKm" value="${booking.endKm}">
                    </div>
                    <div class="form-group">
                        <label>With Driver:</label>
                        <select id="withDriver" name="withDriverStr">
                            <option value="Yes" ${booking.withDriver ? 'selected' : ''}>Yes</option>
                            <option value="No" ${!booking.withDriver ? 'selected' : ''}>No</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Driver Cost (Rs.):</label>
                        <input type="number" step="0.01" id="driverCost" name="driverCost" value="${booking.driverCost}">
                    </div>
                    <div class="form-group">
                        <label>Paid Amount (Rs.):</label>
                        <input type="number" step="0.01" id="paidAmount" name="paidAmount" value="${booking.paidAmount}">
                    </div>
                    <div class="form-group">
                        <label>Payment Status:</label>
                        <select id="paymentStatus" name="paymentStatus">
                            <option value="Online Payment Done" ${booking.paymentStatus == 'Online Payment Done' ? 'selected' : ''}>Online Payment Done</option>
                            <option value="Cash Payment" ${booking.paymentStatus == 'Cash Payment' ? 'selected' : ''}>Cash Payment</option>
                            <option value="Cash Payment Done" ${booking.paymentStatus == 'Cash Payment Done' ? 'selected' : ''}>Cash Payment Done</option>
                            <option value="Pending" ${booking.paymentStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Extra Charges (Rs.):</label>
                        <input type="number" step="0.01" id="extraCharges" name="extraCharges" value="${booking.extraCharges}">
                    </div>
                    <div class="form-group">
                        <label>Extra Charges Status:</label>
                        <select id="extraChargesStatus" name="extraChargesStatus">
                            <option value="Pending" ${booking.extraChargesStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                            <option value="Done" ${booking.extraChargesStatus == 'Done' ? 'selected' : ''}>Done</option>
                            <option value="No Charges" ${booking.extraChargesStatus == 'No Charges' ? 'selected' : ''}>No Charges</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Refundable Amount (Rs.):</label>
                        <input type="number" step="0.01" id="refundableAmount" name="refundableAmount" value="${booking.refundableAmount}">
                    </div>
                    <div class="form-group">
                        <label>Refundable Status:</label>
                        <select id="refundableStatus" name="refundableStatus">
                            <option value="Pending" ${booking.refundableStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                            <option value="Refundable Done" ${booking.refundableStatus == 'Refundable Done' ? 'selected' : ''}>Refundable Done</option>
                            <option value="No Refund" ${booking.refundableStatus == 'No Refund' ? 'selected' : ''}>No Refund</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Total Bill (Rs.):</label>
                        <input type="number" step="0.01" id="totalBill" name="totalBill" value="${booking.totalAmount}">
                    </div>

                    <div class="buttons">
                        <button type="button" id="viewBillBtn" class="view-btn">View Bill</button>
                        <button type="submit" class="update-booking">Update</button>
                    </div>
                </form>
            </div>

            <h2 id="Detailstitle">Booking Details</h2>
            <div class="search-container">
                <input type="text" id="tableSearchInput" placeholder="Search booking table..." onkeyup="filterTable()">
            </div>
            <table id="bookingTable">
                <thead>
                    <tr>
                        <th>Booking No</th>
                        <th>Car No</th>
                        <th>Customer NIC</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Destination</th>
                        <th>Start KM</th>
                        <th>End KM</th>
                        <th>With Driver</th>
                        <th>Driver Cost (Rs)</th>
                        <th>Paid Amount (Rs)</th>
                        <th>Payment Status</th>
                        <th>Extra Charges (Rs)</th>
                        <th>Extra Charges Status</th>
                        <th>Refundable Amount (Rs)</th>
                        <th>Refundable Status</th>
                        <th>Total Bill (Rs)</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${bookings}" var="booking" varStatus="status">
                        <tr>
                            <td>${booking.bookingNo}</td>
                            <td>${booking.carNo}</td>
                            <td><c:out value="${booking.customerNic}" default="N/A"/></td>
                            <td><c:out value="${startDates[booking.id]}" default="N/A"/></td>
                            <td><c:out value="${endDates[booking.id]}" default="N/A"/></td>
                            <td><c:out value="${booking.destination}" default="N/A"/></td>
                            <td><c:out value="${booking.startKm}" default="N/A"/></td>
                            <td><c:out value="${booking.endKm}" default="N/A"/></td>
                            <td>${booking.withDriver ? 'Yes' : 'No'}</td>
                            <td><c:out value="${booking.driverCost}" default="0.00"/></td>
                            <td><c:out value="${booking.paidAmount}" default="0.00"/></td>
                            <td><c:out value="${booking.paymentStatus}" default="Pending"/></td>
                            <td><c:out value="${booking.extraCharges}" default="0.00"/></td>
                            <td><c:out value="${booking.extraChargesStatus}" default="No Charges"/></td>
                            <td><c:out value="${booking.refundableAmount}" default="0.00"/></td>
                            <td><c:out value="${booking.refundableStatus}" default="No Refund"/></td>
                            <td><c:out value="${booking.totalAmount}" default="0.00"/></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/bookings/edit/${booking.bookingNo}" class="edit-btn">Edit</a>
                                <button class="remove-btn" onclick="removeBooking('${booking.bookingNo}')">Remove</button>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty bookings}">
                        <tr>
                            <td colspan="18" style="text-align: center;">No bookings found</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function toggleSubmenu() {
            const submenu = document.getElementById('pagesSubmenu');
            submenu.style.display = submenu.style.display === 'block' ? 'none' : 'block';
        }

        function filterTable() {
            const input = document.getElementById('tableSearchInput').value.toUpperCase();
            const table = document.getElementById('bookingTable');
            const tr = table.getElementsByTagName('tr');

            for (let i = 1; i < tr.length; i++) {
                let found = false;
                const td = tr[i].getElementsByTagName('td');

                // Skip if there are no cells (like the "No bookings found" row)
                if (td.length === 0 || td.length === 1) continue;

                for (let j = 0; j < 3; j++) { // Search in first 3 columns (booking no, car no, customer nic)
                    const cell = td[j];
                    if (cell) {
                        const txtValue = cell.textContent || cell.innerText;
                        if (txtValue.toUpperCase().indexOf(input) > -1) {
                            found = true;
                            break;
                        }
                    }
                }

                tr[i].style.display = found ? '' : 'none';
            }
        }

        function removeBooking(bookingNo) {
            if (confirm('Are you sure you want to remove this booking?')) {
                fetch(`${pageContext.request.contextPath}/api/admin/bookings/${bookingNo}`, {
                    method: 'DELETE'
                })
                .then(response => {
                    if (response.ok) {
                        alert('Booking removed successfully');
                        window.location.reload();
                    } else {
                        throw new Error('Failed to remove booking');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error removing booking: ' + error.message);
                });
            }
        }

        document.getElementById('viewBillBtn').addEventListener('click', function() {
            const bookingNo = document.getElementById('bookingNo').value;
            if (bookingNo) {
                window.open(`${pageContext.request.contextPath}/download-bill/${bookingNo}?finalBill=true`, '_blank');
            } else {
                alert('Please select a booking first');
            }
        });

        // Calculate total bill when values change
        document.getElementById('extraCharges').addEventListener('input', calculateTotalBill);
        document.getElementById('refundableAmount').addEventListener('input', calculateTotalBill);
        document.getElementById('driverCost').addEventListener('input', calculateTotalBill);

        // Store original values for calculation
        let originalBaseAmount = 0;
        let originalDriverCost = parseFloat(document.getElementById('driverCost').value || 0);
        let originalExtraCharges = parseFloat(document.getElementById('extraCharges').value || 0);
        let originalRefundableAmount = parseFloat(document.getElementById('refundableAmount').value || 0);
        let originalTotalAmount = parseFloat(document.getElementById('totalBill').value || 0);

        // Calculate base amount (total - extras + refundable - driver)
        if (originalTotalAmount && originalTotalAmount > 0) {
            originalBaseAmount = originalTotalAmount - originalExtraCharges + originalRefundableAmount - originalDriverCost;
        }

        function calculateTotalBill() {
            const extraCharges = parseFloat(document.getElementById('extraCharges').value || 0);
            const refundableAmount = parseFloat(document.getElementById('refundableAmount').value || 0);
            const driverCost = parseFloat(document.getElementById('driverCost').value || 0);

            const totalBill = originalBaseAmount + extraCharges - refundableAmount + driverCost;
            document.getElementById('totalBill').value = totalBill.toFixed(2);
        }
    </script>
</body>
</html>