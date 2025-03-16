<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>About Us</title>
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
    .hotel-info {
      display: flex;
      flex-direction: column;
      justify-content: center;
      font-family: 'Times New Roman', Times, serif;
      max-width: 550px;
    }
    .hotel-info h2 {
      font-size: 40px;
      margin-bottom: 50px;
    }
    .hotel-info p {
      font-size: 18px;
      margin-bottom: 30px;
    }
    .content-wrapper {
      display: flex;
      flex-direction: row;
      justify-content: space-between;
      padding: 100px 80px;
    }
    .image-container {
      display: flex;
      justify-content: center;
      width: 400px;
      margin-left: 650px;
      position: absolute;
    }
    .image-container img {
      width: 100%;
      height: 100%;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .image-container img:first-child {
      width: 500px;
      height: 500px;
      margin-top: 70px;
      position: absolute;
    }
    .image-container img:last-child {
      width: 500px;
      height: 500px;
      margin-left: 550px;
    }
    .members {
      width: 90%;
      height: auto;
      background-color: #f9f1eb;
      padding: 30px;
      margin-top: 100px;
      margin-left: 70px;
      font-family: 'Times New Roman', Times, serif;
    }
    .members h1 {
      text-align: center;
      margin-top: 20px;
      font-size: 36px;
      color: #333;
    }
    .members h2 {
      text-align: center;
      font-size: 18px;
      color: #666;
      letter-spacing: 2px;
    }
    .team-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      padding: 20px;
      gap: 20px;
    }
    .team-member {
      width: 260px;
      text-align: center;
      background-color: #fff;
      padding: 15px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .team-member img {
      width: 100%;
      height: 250px;
      margin-bottom: 15px;
      border: 2px solid #ddd;
    }
    .team-member h3 {
      font-size: 18px;
      color: #333;
      margin: 5px 0;
    }
    .team-member p {
      font-size: 14px;
      color: #666;
    }
    .feedback-title {
      text-align: center;
      margin-top: 100px;
      margin-bottom: 50px;
      color: #545353;
      font-family: 'Times New Roman', Times, serif;
    }
    .feedback-carousel {
      text-align: center;
      max-width: 70%;
      margin: 0 auto;
      position: relative;
      font-family: 'Times New Roman', Times, serif;
    }
    .feedback-content {
      padding: 20px;
      background-color: #ffffff;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .feedback-content p {
      font-size: 2rem;
      line-height: 1.6;
      margin-bottom: 15px;
      color: #333;
    }
    .avatars {
      display: flex;
      justify-content: center;
      margin-bottom: 15px;
    }
    .avatars img {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      margin: 0 5px;
    }
    h4 {
      font-size: 1.5rem;
      font-weight: bold;
      color: #222;
    }
    .carousel-controls {
      position: absolute;
      top: 50%;
      width: 100%;
      display: flex;
      justify-content: space-between;
      transform: translateY(-50%);
    }
    .carousel-controls button {
      background: none;
      border: none;
      font-size: 2rem;
      cursor: pointer;
      color: #555;
      transition: color 0.3s;
    }
    .carousel-controls button:hover {
      color: #000;
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
      <img src="https://cdn.powersports.com/cdn-cgi/image/h=600,w=800/00ABD043544C548A168B340F3C60555E.jpg" alt="Carousel Image">
      <h1>About Us</h1>
    </div>

    <div class="content-wrapper">
      <!-- Hotel Info Section -->
      <div class="hotel-info">
        <h2>WHO WE ARE</h2>
        <p>At Mega City Cab, we are committed to providing top-quality car rental services with reliability, affordability, and
          customer satisfaction at the core of our operations. Whether you need a fuel-efficient sedan for a business trip, an SUV
          for a family adventure, or a luxury car for a special occasion, we have the perfect vehicle for you. With a seamless booking
          process, flexible rental plans, and a well-maintained fleet, we ensure that your journey is smooth and stress-free. Our dedicated
          team works around the clock to provide excellent customer support, transparent pricing, and hassle-free pick-up and drop-off
          services. At Mega City Cab, we believe in creating a travel experience that is safe, comfortable, and tailored to your needs.
          Book with us today and let us take you where you need to go—your journey starts here!</p>
      </div>

      <!-- Image Side -->
      <div class="image-container">
        <img src="https://valuepluskw.com/wp-content/uploads/2018/04/Chauffeur-Driven-car-Service.jpg" alt="Car Image 1">
        <img src="https://tehranoffers.com/wp-content/uploads/2023/02/Rent-car-in-Tehran-2.jpg" alt="Car Image 2">
      </div>
    </div>

    <!-- Team Members -->
    <div class="members">
      <h2>BEHIND THE SCENE</h2>
      <h1>Our Team</h1>
      <div class="team-container" id="teamContainer"></div>
    </div>

    <h2 class="feedback-title">GUEST FEEDBACK</h2>

    <!-- Best Feedbacks -->
    <div class="feedback-carousel">
      <div class="feedback-content">
        <p id="feedback-text"></p>
        <div class="avatars" id="avatars"></div>
        <h4 id="feedback-name"></h4>
      </div>
      <div class="carousel-controls">
        <button onclick="prevFeedback()">❮</button>
        <button onclick="nextFeedback()">❯</button>
      </div>
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

  <!-- Team Members Script -->
  <script>
    const teamData = [
      { name: "Jeffery Safina", role: "Chief Executive Officer", img: "https://s3.amazonaws.com/bizenglish/wp-content/uploads/2022/04/07135808/Chathuri-Munaweera.png" },
      { name: "Ethan Reynolds", role: "Chief Marketing Officer", img: "https://media.licdn.com/dms/image/v2/C5103AQF9-G4JRsMQug/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1517560451273?e=2147483647&v=beta&t=-PGG1uGJJ3_vjdodV68OP80IdyBZ8mFciEXg_AibIIE" },
      { name: "Sophia Jenkins", role: "Fleet Manager", img: "https://media.licdn.com/dms/image/v2/C5603AQFa42XW77OgaQ/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1623044623659?e=2147483647&v=beta&t=BM1ACqU4TFiMuk4e6lKLSLZU6TVA2mJHifOP7ZFYc7w" },
      { name: "Noah Anderson", role: "Risk & Compliance Manager", img: "https://media.licdn.com/dms/image/v2/D5603AQHepdOJ4jRdrA/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1675831841330?e=2147483647&v=beta&t=pkee4dMFpMZxH3MvYV1w_1EqdF-5R2IhLTN17gAeFls" }
    ];
    const teamContainer = document.getElementById("teamContainer");
    teamData.forEach(member => {
      const memberCard = document.createElement("div");
      memberCard.className = "team-member";
      memberCard.innerHTML = `
        <img src="${member.img}" alt="${member.name}">
        <h3>${member.name}</h3>
        <p>${member.role}</p>
      `;
      teamContainer.appendChild(memberCard);
    });
  </script>

  <!-- Feedback Script -->
  <script>
    const feedbacks = [
      { text: "The car was in excellent condition, clean, and well-maintained. It felt like driving a brand-new vehicle!", name: "Alice Johnyma", avatars: ["https://media.istockphoto.com/id/1437816897/photo/business-woman-manager-or-human-resources-portrait-for-career-success-company-we-are-hiring.jpg?s=612x612&w=0&k=20&c=tyLvtzutRh22j9GqSGI33Z4HpIwv9vL_MZw_xOE19NQ="] },
      { text: "The deposit policy was fair, and getting my refund was quick and easy!", name: "Bob Smith", avatars: ["https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg"] },
      { text: "Exceptional customer service! The team was friendly, helpful, and responsive.", name: "Catherine Lee", avatars: ["https://writestylesonline.com/wp-content/uploads/2018/11/Three-Statistics-That-Will-Make-You-Rethink-Your-Professional-Profile-Picture-1024x1024.jpg"] },
      { text: "Very well-maintained cars! No mechanical issues, smooth ride, and super clean interior.", name: "Luvice Jonthen", avatars: ["https://www.elitesingles.com.au/wp-content/uploads/sites/77/2020/06/profileprotectionsnap-350x264.jpg"] }
    ];
    let currentIndex = 0;
    let autoCarousel;
    function updateFeedback() {
      const feedbackText = document.getElementById("feedback-text");
      const feedbackName = document.getElementById("feedback-name");
      const avatarsContainer = document.getElementById("avatars");
      const feedback = feedbacks[currentIndex];
      feedbackText.textContent = `"${feedback.text}"`;
      feedbackName.textContent = feedback.name;
      avatarsContainer.innerHTML = "";
      feedback.avatars.forEach((avatar) => {
        const img = document.createElement("img");
        img.src = avatar;
        img.alt = "User Avatar";
        avatarsContainer.appendChild(img);
      });
    }
    function prevFeedback() {
      currentIndex = (currentIndex === 0) ? feedbacks.length - 1 : currentIndex - 1;
      updateFeedback();
      resetAutoCarousel();
    }
    function nextFeedback() {
      currentIndex = (currentIndex === feedbacks.length - 1) ? 0 : currentIndex + 1;
      updateFeedback();
      resetAutoCarousel();
    }
    function startAutoCarousel() {
      autoCarousel = setInterval(() => {
        nextFeedback();
      }, 5000);
    }
    function resetAutoCarousel() {
      clearInterval(autoCarousel);
      startAutoCarousel();
    }
    updateFeedback();
    startAutoCarousel();
  </script>
</body>
</html>