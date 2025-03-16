<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Car Model - ${car.name}</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet"/>
  <link rel="stylesheet" href="/css/StructurePage.css">
  <style>
    /* Additional styles for login prompt */
    .login-required {
        text-align: center;
        padding: 20px;
        background-color: #f9f9f9;
        border-radius: 5px;
        margin-bottom: 20px;
    }

    .login-required p {
        margin-bottom: 15px;
        color: #555;
    }

    .login-btn {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s;
    }

    .login-btn:hover {
        background-color: #45a049;
    }

    .signup-link {
        margin-top: 15px;
        font-size: 0.9em;
    }

    .signup-link a {
        color: #4CAF50;
        text-decoration: none;
    }

    .signup-link a:hover {
        text-decoration: underline;
    }

    .alert {
        padding: 10px;
        margin-bottom: 15px;
        border-radius: 4px;
    }

    .alert-success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }

    .alert-danger {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }

    .profile-icon {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        cursor: pointer;
        margin-left: 15px;
    }

    .welcome-message {
        color: white;
        text-align: center;
        font-size: 18px;
        margin-top: 20px;
    }
  </style>
</head>

<body>
  <div class="hero">
    <!-- Navigation Bar -->
    <div class="navbar">
      <div class="logo">
          <img src="/uploads/logo.png" class="logo-icon">
          <a href="/home" class="logo-link">Mega City Cab</a>
      </div>
      <ul>
          <li><a href="/home">HOME</a></li>
          <li><a href="/cars">RENTALS</a></li>
          <li><a href="/about">ABOUT</a></li>
          <li><a href="/contact">CONTACT</a></li>
      </ul>
      <button class="book-now" onclick="window.location.href='/cars'">Book Now</button>

      <!-- User account section -->
      <div id="userSection">
          <c:choose>
              <c:when test="${not empty sessionScope.user}">
                  <!-- Show profile icon and logout button if user is logged in -->
                  <div class="user-controls">
                      <img src="https://static.vecteezy.com/system/resources/previews/036/280/651/non_2x/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-illustration-vector.jpg"
                           alt="Profile"
                           class="profile-icon"
                           onclick="window.location.href='/profile'">
                      <button class="logout-btn" onclick="window.location.href='/logout'">Logout</button>
                  </div>
              </c:when>
              <c:otherwise>
                  <!-- Empty div to maintain layout when no user is logged in -->
                  <div></div>
              </c:otherwise>
          </c:choose>
      </div>
    </div>

    <!-- Welcome message with user's name if logged in -->
    <c:if test="${not empty sessionScope.user}">
        <div class="welcome-message">
            Welcome back, ${sessionScope.user.firstName}!
        </div>
    </c:if>

    <div class="image-container" id="imageContainer">
      <c:if test="${not empty car.images}">
        <img src="/images/${car.images}" alt="${car.name}" />
      </c:if>
    </div>

    <!-- Alert Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <!-- car model container -->
    <div class="container">
      <div class="detailcontainer">
        <div class="header">
          <h1>${car.name}</h1>
          <p class="price">Rs.${car.price}/day</p>
        </div>

        <div class="car-details">
            <div class="detail">
                <i class="fa-solid fa-users"></i>
                <span>${car.peopleCapacity} People</span>
            </div>
            <div class="detail">
                <i class="fa-solid fa-car"></i>
                <span>${car.doors} Doors</span>
            </div>
            <div class="detail">
                <i class="fa-solid fa-gas-pump"></i>
                <span>${car.fuelLiters} Liters</span>
            </div>
        </div>

        <h2>About this Car</h2>
        <p class="description">${car.aboutCar}</p>

        <h2>Included and Excluded</h2>
        <div class="info-section">
            <ul class="included" id="included-list">
                <c:forEach var="feature" items="${includedFeaturesList}">
                    <li><i class="fa fa-check-circle"></i>${feature}</li>
                </c:forEach>
            </ul>
            <ul class="excluded" id="excluded-list">
                <c:forEach var="feature" items="${excludedFeaturesList}">
                    <li><i class="fa fa-times-circle"></i>${feature}</li>
                </c:forEach>
            </ul>
        </div>
      </div>

      <div class="booking-form">
          <h2>Book this Car</h2>

          <c:choose>
              <c:when test="${not empty sessionScope.user}">
                  <!-- Booking form for logged in users -->
                  <form id="bookingForm" action="/book-car" method="post">
                      <input type="hidden" name="carNo" value="${car.carNo}">

                      <label for="start-date">Start Date</label>
                      <input type="date" id="start-date" name="startDate" class="input-field" required>

                      <label for="end-date">End Date</label>
                      <input type="date" id="end-date" name="endDate" class="input-field" required>

                      <div class="driver-option">
                          <label for="with-driver">
                              <i class="fa-solid fa-user-tie icon"></i> With Driver
                          </label>
                          <input type="checkbox" id="with-driver" name="withDriver" value="true">
                      </div>

                      <p class="driver-price" id="driver-price"></p>

                      <textarea name="message" placeholder="Additional requests or notes" class="input-field"></textarea>

                      <div class="total-price" id="total-price">
                          <p>Base Price: Rs.<span id="base-price">${car.price}</span>/day</p>
                          <p id="driver-cost" style="display:none;">Driver Cost: Rs.<span id="driver-price-value">0</span>/day</p>
                          <p id="duration">Duration: <span id="days-count">0</span> days</p>
                          <p class="total">Total: Rs.<span id="total-amount">0</span></p>
                      </div>

                      <button type="button" class="book-btn" onclick="validateAndSubmit()">Book Car</button>
                  </form>
              </c:when>
              <c:otherwise>
                  <!-- Message for users who aren't logged in -->
                  <div class="login-required">
                      <p>You need to be logged in to book this car.</p>
                      <button class="login-btn" onclick="window.location.href='${pageContext.request.contextPath}/login?redirect=carStructured?carNo=${car.carNo}'">Log In</button>
                      <p class="signup-link">Don't have an account? <a href="${pageContext.request.contextPath}/signup">Sign Up</a></p>
                  </div>
              </c:otherwise>
          </c:choose>
      </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
      <!-- Logo & Slogan -->
      <div class="logo">MEGA CITY CAB</div>
      <div class="slogan">Cab Service Company</div>

      <!-- Menu Sections -->
      <div class="menu">
          <div class="menu-section">
              <a href="/terms">Terms & Conditions</a>
              <a href="/blog">Blog</a>
          </div>
          <div class="menu-section">
              <a href="/feedback">Feedback</a>
              <a href="/support">Support</a>
          </div>
          <div class="menu-section">
              <a href="/about">About Us</a>
              <a href="/contact">Contact Us</a>
          </div>
      </div>

      <!-- Divider -->
      <hr>

      <!-- Social Icons -->
      <div class="social-icons">
          <a href="#" aria-label="Facebook" class="mx-2"><i class="bi bi-facebook"></i></a>
          <a href="#" aria-label="Twitter" class="mx-2"><i class="bi bi-twitter"></i></a>
          <a href="#" aria-label="Instagram" class="mx-2"><i class="bi bi-instagram"></i></a>
          <a href="#" aria-label="Whatsapp" class="mx-2"><i class="bi bi-whatsapp"></i></a>
          <a href="#" aria-label="Youtube" class="mx-2"><i class="bi bi-youtube"></i></a>
      </div>

      <!-- Copyright -->
      <div class="copyright">© Copyright. All rights reserved.</div>
    </footer>

  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Session management script -->
  <script>
    // Check if user is logged in via session
    document.addEventListener("DOMContentLoaded", function () {
        // This is handled by the server-side code using JSTL tags
        // The profile icon and welcome message are displayed conditionally based on session

        // Set minimum date for date inputs to today
        const today = new Date().toISOString().split('T')[0];
        const startDateInput = document.getElementById('start-date');
        const endDateInput = document.getElementById('end-date');

        if (startDateInput && endDateInput) {
            startDateInput.min = today;
            endDateInput.min = today;

            // Update price calculation when dates change
            startDateInput.addEventListener('change', updatePriceCalculation);
            endDateInput.addEventListener('change', updatePriceCalculation);

            // When start date changes, ensure end date is not before start date
            startDateInput.addEventListener('change', function() {
                const startDate = this.value;
                if (startDate) {
                    endDateInput.min = startDate;
                    // If current end date is before new start date, update it
                    if (endDateInput.value && endDateInput.value < startDate) {
                        endDateInput.value = startDate;
                    }
                    updatePriceCalculation();
                }
            });
        }
    });
  </script>

  <!-- Driver price and booking functionality -->
  <script>
    // Show Driver Price when Checked
    const withDriverCheckbox = document.getElementById("with-driver");
    if (withDriverCheckbox) {
        withDriverCheckbox.addEventListener("change", function () {
            updatePriceCalculation();
        });
    }

    // Calculate and update price display
    function updatePriceCalculation() {
        const startDate = document.getElementById("start-date").value;
        const endDate = document.getElementById("end-date").value;
        const withDriver = document.getElementById("with-driver").checked;

        // Base car price
        const carPrice = ${car.price};

        // Calculate driver price (25% of daily car price)
        const driverPrice = Math.round(carPrice * 0.25);

        // Update driver price display
        const driverPriceElement = document.getElementById("driver-price");
        const driverCostElement = document.getElementById("driver-cost");
        const driverPriceValueElement = document.getElementById("driver-price-value");

        if (withDriver) {
            if (driverPriceElement) driverPriceElement.style.display = "block";
            if (driverPriceElement) driverPriceElement.textContent = `Driver Cost: Rs. ${driverPrice}/day`;
            if (driverCostElement) driverCostElement.style.display = "block";
            if (driverPriceValueElement) driverPriceValueElement.textContent = driverPrice;
        } else {
            if (driverPriceElement) driverPriceElement.style.display = "none";
            if (driverCostElement) driverCostElement.style.display = "none";
        }

        // Calculate total price if dates are selected
        if (startDate && endDate) {
            const start = new Date(startDate);
            const end = new Date(endDate);

            // Calculate days difference
            const diffTime = Math.abs(end - start);
            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1; // +1 to include both start and end days

            // Update days display
            const daysCountElement = document.getElementById("days-count");
            if (daysCountElement) daysCountElement.textContent = diffDays;

            // Calculate total price
            let totalPrice = carPrice * diffDays;
            if (withDriver) {
                totalPrice += (driverPrice * diffDays);
            }

            // Update total price display
            const totalAmountElement = document.getElementById("total-amount");
            if (totalAmountElement) totalAmountElement.textContent = totalPrice;
        }
    }

    // Form validation and submission
    function validateAndSubmit() {
        const startDate = document.getElementById("start-date").value;
        const endDate = document.getElementById("end-date").value;

        // Basic validation
        if (!startDate || !endDate) {
            alert("Please select both start and end dates");
            return;
        }

        // Additional validation
        const start = new Date(startDate);
        const end = new Date(endDate);

        if (end < start) {
            alert("End date cannot be before start date");
            return;
        }

        // Submit the form
        document.getElementById("bookingForm").submit();
    }
  </script>
</body>
</html>