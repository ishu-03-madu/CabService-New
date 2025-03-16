<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        /* CSS remains unchanged */
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
            background-image: url(https://img.freepik.com/premium-photo/car-with-lights-sky-is-red_959938-3922.jpg);
            background-size: cover;
            width: 100%;
            min-height: 700px;
            border-top-left-radius: 20px;
            border-bottom-left-radius: 20px;
            box-shadow: 3px 0 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
        }

        .profile-icon {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            color: #555;
            position: relative;
            cursor: pointer;
            overflow: hidden;
            border: 2px solid #ccc;
        }

        .profile-icon img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .profile-icon::after {
            content: "+";
            position: absolute;
            right: 5px;
            bottom: 5px;
            background-color: #fff;
            color: #888;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            font-weight: bold;
            border: 2px solid #ccc;
        }

        .rightside .dashboard {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
            margin-top: 50px;
            margin-left: 150px;
        }

        .card {
            width: 350px;
            height: 180px;
            border: 5px solid rgb(130, 98, 98);
            border-radius: 15px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-size: 18px;
            font-weight: bold;
            text-align: center;
            background: linear-gradient(to bottom, #818080, #3c3c3b);
            color: black;
        }

        .count {
            font-size: 22px;
            font-weight: bold;
            margin-top: 5px;
        }

        .red { color: rgb(245, 141, 110); }
        .gray { color: rgb(238, 230, 9); }

        @media (max-width: 600px) {
            .dashboard {
                grid-template-columns: 1fr;
            }
        }

        /* Profile Popup */
        .popup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            display: none;
            flex-direction: column;
            align-items: center;
            width: 300px;
        }

        .popup.active {
            display: flex;
        }

        .popup #profilePopup .profile-icon {
            width: 100px;
            height: 100px;
            margin-bottom: 10px;
        }

        .popup input[type="file"] {
            display: none;
        }

        .popup label {
            font-weight: bold;
            margin-top: 10px;
        }

        .popup input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            background-color: #f1f1f1;
            pointer-events: none;
        }

        .popup .close-btn {
            margin-top: 10px;
            padding: 8px 16px;
            background: #ff5c5c;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>

<body>
    <%-- Assume these values are fetched from a servlet or database --%>
    <%
        int carBookings = 5;
        int driversBookings = 6;
        int usersCount = 231;
        int adminsCount = 4;
        String profileImageUrl = "https://st3.depositphotos.com/19428878/37137/v/450/depositphotos_371377450-stock-illustration-default-avatar-profile-image-vector.jpg";
        String firstName = "Alen";
        String secondName = "Smith";
        String phoneNo = "2345678";
        String nic = "1112233";
        String position = "Analyst";
        String email = "Alen@gmail.com";
    %>

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
                    <li class="menu-item active">
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
                        <a href="${pageContext.request.contextPath}/admin/updateBooking">
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
            <div class="dashbody">
                <div class="profile-icon" id="openProfile">
                    <img id="dashboardProfileImage" src="<%= profileImageUrl %>">
                </div>

                <div class="dashboard">
                    <div class="card">
                        Car Bookings
                        <div id="carBookings" class="count car red"><%= String.format("%02d", carBookings) %></div>
                    </div>

                    <div class="card">
                        Drivers Bookings
                        <div id="driversBookings" class="count red"><%= String.format("%02d", driversBookings) %></div>
                    </div>

                    <div class="card">
                        Users
                        <div id="usersCount" class="count gray"><%= usersCount %></div>
                    </div>

                    <div class="card">
                        Admins
                        <div id="adminsCount" class="count gray"><%= String.format("%02d", adminsCount) %></div>
                    </div>
                </div>

                <!-- Profile Popup -->
                <div class="popup" id="profilePopup">
                    <label for="profileUpload" class="profile-icon">
                        <img id="profileImage" src="<%= profileImageUrl %>">
                    </label>
                    <input type="file" id="profileUpload" accept="image/*">

                    <label for="firstName">First Name</label>
                    <input type="text" id="firstName" value="<%= firstName %>" readonly>

                    <label for="secondName">Second Name</label>
                    <input type="text" id="secondName" value="<%= secondName %>" readonly>

                    <label for="phoneNo">Phone No</label>
                    <input type="text" id="phoneNo" value="<%= phoneNo %>" readonly>

                    <label for="nic">NIC</label>
                    <input type="text" id="nic" value="<%= nic %>" readonly>

                    <label for="position">Position</label>
                    <input type="text" id="position" value="<%= position %>" readonly>

                    <label for="email">Email</label>
                    <input type="email" id="email" value="<%= email %>" readonly>

                    <button class="close-btn" id="closeProfile">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Sidebar Script -->
    <script>
        function toggleSubmenu() {
            let submenu = document.getElementById("pagesSubmenu");
            submenu.style.display = submenu.style.display === "block" ? "none" : "block";
        }
    </script>

    <!-- Profile Script -->
    <script>
        const openProfile = document.getElementById("openProfile");
        const profilePopup = document.getElementById("profilePopup");
        const closeProfile = document.getElementById("closeProfile");
        const profileUpload = document.getElementById("profileUpload");
        const profileImage = document.getElementById("profileImage");
        const dashboardProfileImage = document.getElementById("dashboardProfileImage");

        openProfile.addEventListener("click", () => {
            profilePopup.classList.add("active");
        });

        closeProfile.addEventListener("click", () => {
            profilePopup.classList.remove("active");
        });

        profileUpload.addEventListener("change", function(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    profileImage.src = e.target.result;
                    dashboardProfileImage.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
    </script>

</body>
</html>