<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact Us</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    /* Existing CSS remains unchanged */
    body {
      margin: 0;
      font-family: Arial, sans-serif;
    }
    .hero {
      height: auto;
      background-color: white;
    }
    .navbar {
      display: flex;
      width: 100%;
      justify-content: space-between;
      align-items: center;
      padding: 10px 0px;
      background: rgb(51, 55, 55);
    }
    .navbar .logo {
      padding: 0px 25px;
    }
    .logo {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .logo-icon {
      width: 40px;
      height: 40px;
    }
    .logo-link {
      text-decoration: none;
      cursor: pointer;
      color: #ff4d4d;
      text-shadow: 4px 4px 8px rgba(0, 0, 0, 0.5);
      font-size: 26px;
      font-weight: bold;
      font-family: cursive;
      font-style: italic;
      text-transform: uppercase;
    }
    .navbar ul {
      list-style: none;
      display: flex;
      gap: 30px;
      margin: 0;
      padding: 0;
      flex-grow: 1;
      justify-content: center;
    }
    .navbar ul li {
      display: inline;
    }
    .navbar ul li a {
      text-decoration: none;
      font-family: Georgia, 'Times New Roman', Times, serif;
      color: white;
      font-size: 18px;
      transition: color 0.3s;
    }
    .navbar ul li a:hover {
      color: #ff5b5b;
    }
    .book-now {
      margin-right: 15px;
      display: flex;
      color: #ff5b5b;
      padding: 10px 20px;
      background: transparent;
      border: 1px solid #ff5b5b;
      border-radius: 15px;
      font-family: Georgia, 'Times New Roman', Times, serif;
      font-size: 14px;
      font-weight: bold;
      text-transform: uppercase;
      cursor: pointer;
    }
    .book-now:hover {
      background: #ff5b5b;
      border: 1px solid black;
      color: black;
    }
    .profile-icon {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      cursor: pointer;
      margin-right: 10px;
    }
    .carousel {
      position: relative;
      width: 100%;
      height: 300px;
    }
    .carousel img {
      width: 100%;
      height: 300px;
      object-fit: cover;
    }
    .carousel-overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      z-index: 1;
    }
    .carousel h1 {
      position: absolute;
      top: 40%;
      left: 50%;
      transform: translate(-50%, -50%);
      z-index: 2;
      color: #fff;
      font-size: 48px;
      font-family: 'Times New Roman', Times, serif;
      text-shadow: 0 2px 4px rgba(0, 0, 0, 0.6);
    }
    .contact-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      padding: 100px;
      width: 100%;
      margin: 0 auto;
      background-color: #fff;
      gap: 20px;
    }
    .contact-info {
      flex: 1;
      margin-right: 20px;
      min-width: 300px;
    }
    .contact-info h2 {
      font-size: 26px;
      margin-bottom: 20px;
    }
    .contact-info p {
      line-height: 1.6;
      margin-bottom: 20px;
    }
    .info-item {
      display: flex;
      align-items: center;
      margin-bottom: 15px;
    }
    .icon {
      font-size: 24px;
      margin-right: 15px;
      color: rgb(232, 179, 47);
    }
    .contact-form {
      flex: 1;
      min-width: 300px;
    }
    .contact-form h6 {
      text-align: center;
      color: rgb(169, 128, 26);
    }
    .contact-form h2 {
      font-size: 24px;
      margin-bottom: 30px;
      text-align: center;
    }
    form {
      display: flex;
      flex-direction: column;
    }
    .form-group {
      display: flex;
      gap: 15px;
      margin-bottom: 15px;
    }
    input, textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 14px;
      margin-bottom: 20px;
    }
    textarea {
      resize: none;
      height: 100px;
      margin-bottom: 15px;
    }
    .contact-form button {
      width: 200px;
      background-color: rgb(232, 179, 47);
      color: #fff;
      border: none;
      padding: 10px 15px;
      font-size: 16px;
      cursor: pointer;
      border-radius: 5px;
      transition: background-color 0.3s;
    }
    .contact-form button:hover {
      background-color: #e07b00;
    }
    .map-container {
      width: 90%;
      height: 500px;
      margin: auto;
      border: 1px solid #ddd;
      overflow: hidden;
    }
    iframe {
      width: 100%;
      height: 100%;
      border: none;
    }
    .footer {
      margin-top: 100px;
      background: url(https://media.istockphoto.com/id/927422762/vector/silhouette-of-a-automotive-car.jpg?s=612x612&w=0&k=20&c=sg301t-Njw4z9ev_KHLto-63KcYS-L4lhI6qtmxKBhk=);
      background-size: cover;
      background-repeat: no-repeat;
      background-position: center;
      color: white;
      padding: 40px 20px;
      text-align: center;
    }
    .footer .logo {
      text-decoration: none;
      display: flex;
      justify-content: center;
      cursor: pointer;
      color: #ff4d4d;
      text-shadow: 4px 4px 8px rgba(0, 0, 0, 0.5);
      font-size: 26px;
      font-weight: bold;
      font-family: cursive;
      font-style: italic;
      text-transform: uppercase;
    }
    .footer .slogan {
      font-size: 12px;
      margin-top: 5px;
      color: #ddcfb6;
    }
    .footer .menu {
      display: flex;
      justify-content: center;
      flex-wrap: wrap;
      margin: 30px 0;
    }
    .footer .menu div {
      margin: 0 50px;
    }
    .footer .menu div a {
      display: block;
      color: #ccbca0;
      font-weight: bold;
      font-size: 18px;
      margin: 15px 0;
      text-decoration: none;
      transition: color 0.3s;
      text-shadow: 4px 4px 8px rgba(0, 0, 0, 0.5);
    }
    .footer .menu div a:hover {
      color: #c5b08d;
      text-decoration: underline;
    }
    .social-icons a {
      display: inline-flex;
      justify-content: center;
      align-items: center;
      width: 35px;
      height: 35px;
      margin: 0 10px;
      border-radius: 50%;
      background-color: #f0f0f0;
      text-decoration: none;
      transition: transform 0.3s, background-color 0.3s;
    }
    .social-icons a:hover {
      transform: scale(1.1);
      background-color: #dcdcdc;
    }
    .social-icons a i {
      font-size: 18px;
      color: #bb3434;
      transition: color 0.3s;
    }
    .social-icons a:hover i {
      color: #000;
    }
    .footer .copyright {
      font-size: 12px;
      color: #fff;
      margin-top: 20px;
    }
    .footer hr {
      margin: 30px auto;
      border: 0;
      height: 2px;
      background-color: #787878;
      width: 80%;
    }
  </style>
</head>

<body>
  <div>
    <!-- Navigation Bar -->
    <div class="navbar">
      <div class="logo">
        <img src="${pageContext.request.contextPath}/uploads/logo.png" class="logo-icon" alt="Logo">
        <a href="<c:url value='/home' />" class="logo-link">Mega City Cab</a>
      </div>
      <ul>
        <li><a href="<c:url value='/home' />">HOME</a></li>
        <li><a href="<c:url value='/carDisplay' />">RENTALS</a></li>
        <li><a href="<c:url value='/about' />">ABOUT</a></li>
        <li><a href="<c:url value='/contact' />">CONTACT</a></li>
      </ul>
      <button class="book-now" onclick="window.location.href='<c:url value='/carDisplay' />'">Book Now</button>
      <div id="profileIconContainer"></div>
    </div>

    <!-- Carousel -->
    <div class="carousel">
      <div class="carousel-overlay"></div>
      <img src="https://media.istockphoto.com/id/1068158540/photo/beautiful-friendly-hotel-receptionist-answering-a-call-from-a-guest.jpg?s=612x612&w=0&k=20&c=t2mliujfNPUFF6lhUF9zcvaqhUDdUR2TbNh5VaVobDY=" alt="Contact Us Image">
      <h1>Contact Us</h1>
    </div>

    <div class="contact-container">
      <!-- Contact Info -->
      <div class="contact-info">
        <h2>Mega City Cab</h2>
        <p>
          Stay updated with Mega City Cab’s latest offers and services! Enjoy exclusive discounts, special deals,
          and premium rental options. Discover new vehicle additions, seasonal promotions, and travel tips for a hassle-free ride.
          Follow us on social media for real-time updates, giveaways, and exciting offers. Let us make every journey with
          Mega City Cab smooth, affordable, and truly exceptional!
        </p>
        <div class="info-item">
          <span class="icon"><i class="bi bi-telephone-fill"></i></span>
          <div>
            <strong>Reservation</strong>
            <p id="reservation-number"></p>
          </div>
        </div>
        <div class="info-item">
          <span class="icon"><i class="bi bi-envelope-fill"></i></span>
          <div>
            <strong>Email Info</strong>
            <p id="email-info"></p>
          </div>
        </div>
        <div class="info-item">
          <span class="icon"><i class="bi bi-geo-alt-fill"></i></span>
          <div>
            <strong>Address</strong>
            <p id="address"></p>
          </div>
        </div>
      </div>

      <!-- Message Form -->
      <div class="contact-form">
        <h6>Have any questions?</h6>
        <h2>Let's start a conversation</h2>
        <form:form action="${pageContext.request.contextPath}/contact/submit" method="post" modelAttribute="contactForm">
          <div class="form-group">
            <form:input path="name" placeholder="Your Name *" required="true"/>
            <form:input path="email" type="email" placeholder="Your Email *" required="true"/>
          </div>
          <div class="form-group">
            <form:input path="phoneNumber" type="tel" placeholder="Phone Number *" required="true"/>
            <form:input path="subject" placeholder="Subject *" required="true"/>
          </div>
          <form:textarea path="message" placeholder="Message *" required="true"/>
          <button type="submit">SEND MESSAGE</button>
        </form:form>
      </div>
    </div>

    <!-- Map -->
    <div class="map-container">
      <iframe id="locationMap" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
    </div>

    <!-- Footer -->
    <footer class="footer">
      <div class="logo">MEGA CITY CAB</div>
      <div class="slogan">Cab Service Company</div>
      <div class="menu">
        <div class="menu-section">
          <a href="<c:url value='/terms' />">Terms & Conditions</a>
          <a href="<c:url value='/blog' />">Blog</a>
        </div>
        <div class="menu-section">
          <a href="<c:url value='/feedback' />">Feedback</a>
          <a href="<c:url value='/support' />">Support</a>
        </div>
        <div class="menu-section">
          <a href="<c:url value='/about' />">About Us</a>
          <a href="<c:url value='/contact' />">Contact Us</a>
        </div>
      </div>
      <hr>
      <div class="social-icons">
        <a href="#" aria-label="Facebook" class="mx-2"><i class="bi bi-facebook"></i></a>
        <a href="#" aria-label="Twitter" class="mx-2"><i class="bi bi-twitter"></i></a>
        <a href="#" aria-label="Instagram" class="mx-2"><i class="bi bi-instagram"></i></a>
        <a href="#" aria-label="Whatsapp" class="mx-2"><i class="bi bi-whatsapp"></i></a>
        <a href="#" aria-label="Youtube" class="mx-2"><i class="bi bi-youtube"></i></a>
      </div>
      <div class="copyright">© Copyright. All rights reserved.</div>
    </footer>
  </div>

  <!-- Navbar Profile Script -->
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      let profileIconContainer = document.getElementById("profileIconContainer");
      if (sessionStorage.getItem("isLoggedIn") === "true") {
        profileIconContainer.innerHTML = `
          <img src="https://static.vecteezy.com/system/resources/previews/036/280/651/non_2x/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-illustration-vector.jpg"
               alt="Profile"
               class="profile-icon"
               onclick="window.location.href='<c:url value='/profile' />'">
        `;
      } else {
        profileIconContainer.innerHTML = "";
      }
    });
  </script>

  <!-- Contact Info Script -->
  <script>
    const reservationNumber = "+94 11 3458 899";
    const emailInfo = "info@megacitycab.com";
    const address = "26/7 Dark Road, Kirulapana, Colombo";
    document.getElementById("reservation-number").textContent = reservationNumber;
    document.getElementById("email-info").textContent = emailInfo;
    document.getElementById("address").textContent = address;
  </script>

  <!-- Map Script -->
  <script>
    const locationData = {
      name: "Weligama City Beginner's Surf beach",
      embedUrl: "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3419.7734993309778!2d79.91774027396752!3d6.846582601695225!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae251d24702d94f%3A0xd4e5be09be52d486!2sRent%20A%20Car%20Maharagama!5e1!3m2!1sen!2slk!4v1741647770299!5m2!1sen!2slk"
    };
    document.getElementById("locationMap").src = locationData.embedUrl;
  </script>
</body>
</html>