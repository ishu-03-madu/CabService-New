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
      <div id="profileIconContainer"></div>
    </div>

    <div class="image-container" id="imageContainer">
      <c:if test="${not empty car.images}">
        <img src="/images/${car.images}" alt="${car.name}" />
      </c:if>
    </div>

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
          <input type="date" id="start-date" class="input-field">
          <input type="date" id="end-date" class="input-field">

          <div class="driver-option">
              <label for="with-driver">
                  <i class="fa-solid fa-user-tie icon"></i> With Driver
              </label>
              <input type="checkbox" id="with-driver">
          </div>

          <p class="driver-price" id="driver-price"></p>

          <textarea placeholder="Type here message" class="input-field"></textarea>
          <button class="book-btn">Book Car</button>
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

  <!-- navbar profile -->
  <script>
    document.addEventListener("DOMContentLoaded", function () {
        let profileIconContainer = document.getElementById("profileIconContainer");

        if (sessionStorage.getItem("isLoggedIn") === "true") {
            profileIconContainer.innerHTML = `
                <img src="https://static.vecteezy.com/system/resources/previews/036/280/651/non_2x/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-illustration-vector.jpg"
                     alt="Profile"
                     class="profile-icon"
                     onclick="window.location.href='/profile'">
            `;
        } else {
            profileIconContainer.innerHTML = ""; // Hide profile icon if not logged in
        }
    });
  </script>

  <!-- Show Driver Price when Checked -->
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      // Set driver price based on car price (example: 25% of daily car price)
      const carPrice = ${car.price};
      const driverPrice = Math.round(carPrice * 0.25);

      // Show Driver Price when Checked
      document.getElementById("with-driver").addEventListener("change", function () {
        document.getElementById("driver-price").style.display = this.checked ? "block" : "none";
        document.getElementById("driver-price").textContent = this.checked ? `Driver Cost: Rs. ${driverPrice}` : "";
      });
    });
  </script>

</body>
</html>