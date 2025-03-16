<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Availability</title>
    <style>
        /* Base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #2c2b2b;
        }

        .dashboard{
            display: flex;
            justify-content: center;
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

        /* Right side content */
        .rightside {
            background-color: #f5f5f5;
            width: 100%;
            min-height: 700px;
            border-top-left-radius: 20px;
            border-bottom-left-radius: 20px;
            box-shadow: 3px 0 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
            overflow-y: auto;
        }

        /* Table styles */
        h2 {
            margin: 20px 0;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #333;
            color: white;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        /* Form elements */
        select, input[type="text"], input[type="date"] {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 5px;
        }

        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            color: white;
            margin-right: 5px;
        }

        .btn-update {
            background-color: #2196F3;
        }

        .btn-done {
            background-color: #4CAF50;
        }

        /* Search box */
        .search-box {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 300px;
            margin-right: 10px;
        }

        /* Salary section */
        .salary-section {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-top: 20px;
        }

        .salary-section h3 {
            margin-bottom: 15px;
            color: #333;
        }

        .date-picker {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin: 0 10px;
        }

        .driveridsalary {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 150px;
        }

        .salary-box {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 150px;
            font-weight: bold;
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/images/logo.png" class="logo-icon" alt="Logo">
                <a href="${pageContext.request.contextPath}/dashboard" class="logo-link">Mega City Cab</a>
            </div>
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
                    <li class="menu-item">
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
                        <li class="menu-item active">
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
            <div class="logout" onclick="location.href='${pageContext.request.contextPath}/logout'">
                <span class="icon">🚪</span> Logout
            </div>
        </div>

        <div class="rightside">
            <h2>Driver Availability</h2>

            <c:if test="${not empty success}">
                <div style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 4px; margin-bottom: 15px;">
                    ${success}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div style="background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px;">
                    ${error}
                </div>
            </c:if>

            <table>
                <thead>
                    <tr>
                        <th>Driver ID</th>
                        <th>Driver Name</th>
                        <th>Availability</th>
                        <th>Booking No</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${drivers}" var="driver">
                        <tr>
                            <td>${driver.driverId}</td>
                            <td>${driver.firstName} ${driver.secondName}</td>
                            <td>
                                <form id="availabilityForm${driver.driverId}" action="${pageContext.request.contextPath}/drivers/availability/update" method="post">
                                    <input type="hidden" name="driverId" value="${driver.driverId}">
                                    <select name="available" id="available${driver.driverId}" onchange="toggleBookingNo('${driver.driverId}')">
                                        <option value="true" <c:if test="${driver.available}">selected</c:if>>Available</option>
                                        <option value="false" <c:if test="${!driver.available}">selected</c:if>>Unavailable</option>
                                    </select>
                                    <input type="text" name="bookingNo" id="bookingNo${driver.driverId}" value="${driver.currentBookingNo}" <c:if test="${driver.available}">style="display:none;"</c:if> placeholder="Booking No">
                                </form>
                            </td>
                            <td>${driver.currentBookingNo}</td>
                            <td>
                                <c:if test="${!driver.available}">
                                    <a href="${pageContext.request.contextPath}/drivers/ride/done/${driver.driverId}" class="btn btn-done" onclick="return confirm('Mark this ride as done?')">Done</a>
                                </c:if>
                                <button class="btn btn-update" onclick="updateAvailability('${driver.driverId}')">Update</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <h2>Driver History</h2>
            <form action="${pageContext.request.contextPath}/drivers/history/search" method="get">
                <input type="text" name="keyword" class="search-box" placeholder="Search by NIC or Driver ID" value="${searchKeyword}">
                <button type="submit" class="btn btn-update">Search</button>
            </form>

            <table>
                <thead>
                    <tr>
                        <th>Driver ID</th>
                        <th>NIC</th>
                        <th>First Name</th>
                        <th>Booking ID</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Ride Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${driverHistories}" var="history">
                        <tr>
                            <td>${history.driverId}</td>
                            <td>${history.nic}</td>
                            <td>${history.firstName}</td>
                            <td>${history.bookingId}</td>
                            <td><fmt:formatDate value="${history.startDate}" pattern="dd/MM/yyyy" /></td>
                            <td><fmt:formatDate value="${history.endDate}" pattern="dd/MM/yyyy" /></td>
                            <td>${history.rideAmount}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <hr>
            <div class="salary-section">
                <h3>Calculate Total Salary</h3>
                <form id="salaryForm" onsubmit="calculateSalary(); return false;">
                    <label>Driver ID:</label>
                    <input type="text" id="driverIdSalary" class="driveridsalary" placeholder="Driver ID" required>
                    <label>Start Date:</label>
                    <input type="date" id="startDate" class="date-picker" required>
                    <label>End Date:</label>
                    <input type="date" id="endDate" class="date-picker" required>
                    <button type="submit" class="btn btn-update">Calculate</button>
                    <br>
                    <label>Total Salary:</label>
                    <input type="text" id="salaryResult" class="salary-box" placeholder="Rs." readonly>
                </form>
            </div>
        </div>
    </div>

    <script>
        function toggleSubmenu() {
            let submenu = document.getElementById("pagesSubmenu");
            submenu.style.display = submenu.style.display === "block" ? "none" : "block";
        }

        function toggleBookingNo(driverId) {
            console.log('Toggling for driver: ' + driverId);
            const available = document.getElementById('available' + driverId).value;
            const bookingNoField = document.getElementById('bookingNo' + driverId);
            console.log('Available: ' + available);
            if (available === 'false') {
                bookingNoField.style.display = 'inline';
                bookingNoField.required = true;
            } else {
                bookingNoField.style.display = 'none';
                bookingNoField.required = false;
                bookingNoField.value = '';
            }
        }

        function updateAvailability(driverId) {
            console.log('Updating driver: ' + driverId);
            const available = document.getElementById('available' + driverId).value;
            const bookingNoField = document.getElementById('bookingNo' + driverId);
            if (available === 'false' && !bookingNoField.value) {
                alert('Please enter a booking number when setting driver as unavailable.');
                return;
            }
            const form = document.getElementById('availabilityForm' + driverId);
            console.log('Form found: ', form);
            form.submit();
        }

        function calculateSalary() {
            const driverId = document.getElementById('driverIdSalary').value;
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;

            fetch(`${pageContext.request.contextPath}/api/drivers/${driverId}/salary?startDate=${startDate}&endDate=${endDate}`)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('salaryResult').value = `Rs. ${data.totalSalary.toFixed(2)}`;
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error calculating salary. Ensure driver ID and dates are valid.');
                });
        }
    </script>
</body>
</html>