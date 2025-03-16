<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Details</title>
    <style>
        /* Same CSS as before */
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

        .rightside{
            background-color: #f5f5f5;
            width: 100%;
            min-height: 700px;
            border-top-left-radius: 20px;
            border-bottom-left-radius: 20px;
            box-shadow: 3px 0 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
            overflow-y: auto;
        }

        /* Form styling */
        .form-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
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

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }

        .btn-add {
            background-color: #4CAF50;
            color: white;
        }

        .btn-clear {
            background-color: #f44336;
            color: white;
        }

        .btn-cancel {
            background-color: #2196F3;
            color: white;
        }

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
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

        .btn-action {
            padding: 5px 10px;
            margin: 2px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            color: white;
        }

        .btn-update {
            background-color: #2196F3;
        }

        .btn-delete {
            background-color: #f44336;
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
                        <li class="menu-item active">
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
            <div class="logout" onclick="location.href='${pageContext.request.contextPath}/logout'">
                <span class="icon">🚪</span> Logout
            </div>
        </div>

        <div class="rightside">
            <div class="form-container">
                <h2>ADD/UPDATE DRIVER</h2>
                <c:if test="${not empty error}">
                    <p style="color: red;">${error}</p>
                </c:if>
                <form:form action="${pageContext.request.contextPath}/drivers/add" method="post" modelAttribute="driver" id="driverForm">
                    <form:hidden path="driverId" id="driverId" />

                    <div class="form-group">
                        <label for="firstName">First Name</label>
                        <form:input path="firstName" id="firstName" required="true" />
                    </div>
                    <div class="form-group">
                        <label for="secondName">Second Name</label>
                        <form:input path="secondName" id="secondName" required="true" />
                    </div>
                    <div class="form-group">
                        <label for="nic">NIC</label>
                        <form:input path="nic" id="nic" required="true" />
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <form:input path="phone" id="phone" required="true" pattern="[0-9]{10}" title="Enter a 10-digit phone number" />
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <form:input path="address" id="address" required="true" />
                    </div>
                    <div class="form-group">
                        <label for="licenseNo">License No</label>
                        <form:input path="licenseNo" id="licenseNo" required="true" />
                    </div>
                    <div class="form-group">
                        <label for="available">Availability</label>
                        <form:select path="available" id="available">
                            <form:option value="true">Available</form:option>
                            <form:option value="false">Unavailable</form:option>
                        </form:select>
                    </div>

                    <div class="button-container">
                        <button type="submit" class="btn btn-add" id="submitBtn">Add</button>
                        <button type="button" class="btn btn-clear" onclick="clearForm()">Clear</button>
                        <button type="button" class="btn btn-cancel" onclick="resetForm()" style="display:none;" id="cancelBtn">Cancel</button>
                    </div>
                </form:form>
            </div>

            <h2>DRIVER LIST</h2>
            <table>
                <thead>
                    <tr>
                        <th>Driver ID</th>
                        <th>First Name</th>
                        <th>Second Name</th>
                        <th>NIC</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>License No</th>
                        <th>Availability</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${drivers}" var="driver">
                        <tr>
                            <td>${driver.driverId}</td>
                            <td>${driver.firstName}</td>
                            <td>${driver.secondName}</td>
                            <td>${driver.nic}</td>
                            <td>${driver.phone}</td>
                            <td>${driver.address}</td>
                            <td>${driver.licenseNo}</td>
                            <td>${driver.available ? 'Available' : 'Unavailable'}</td>
                            <td>
                                <button class="btn-action btn-update" onclick="editDriver('${driver.driverId}')">Update</button>
                                <a href="${pageContext.request.contextPath}/drivers/delete/${driver.driverId}" class="btn-action btn-delete" onclick="return confirm('Are you sure you want to delete this driver?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function toggleSubmenu() {
            let submenu = document.getElementById("pagesSubmenu");
            submenu.style.display = submenu.style.display === "block" ? "none" : "block";
        }

        function clearForm() {
            document.getElementById("driverForm").reset();
            document.getElementById("driverId").value = "";
            document.getElementById("submitBtn").innerText = "Add";
            document.getElementById("cancelBtn").style.display = "none";
            document.getElementById("driverForm").action = "${pageContext.request.contextPath}/drivers/add";
        }

        function resetForm() {
            clearForm();
        }

        function editDriver(driverId) {
            fetch('${pageContext.request.contextPath}/drivers/edit/' + driverId)
                .then(response => response.json())
                .then(data => {
                    document.getElementById("driverId").value = data.driverId;
                    document.getElementById("firstName").value = data.firstName;
                    document.getElementById("secondName").value = data.secondName;
                    document.getElementById("nic").value = data.nic;
                    document.getElementById("phone").value = data.phone;
                    document.getElementById("address").value = data.address;
                    document.getElementById("licenseNo").value = data.licenseNo;
                    document.getElementById("available").value = data.available.toString();

                    document.getElementById("submitBtn").innerText = "Update";
                    document.getElementById("cancelBtn").style.display = "inline-block";
                    document.getElementById("driverForm").action = "${pageContext.request.contextPath}/drivers/update";

                    document.querySelector(".form-container").scrollIntoView();
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error fetching driver details');
                });
        }
    </script>
</body>
</html>