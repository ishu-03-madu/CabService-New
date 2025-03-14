<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Home - Mega City Cab</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <style> </style>
</head>

<body>
  <div class="hero">
    <!-- Navigation Bar -->
    <div class="navbar">
        <div class="logo">
            <img src="<c:url value='/resources/uploads/logo.png' />" class="logo-icon">
            <a href="<c:url value='/home' />" class="logo-link">Mega City Cab</a>
        </div>
        <ul>
            <li><a href="<c:url value='/home' />">HOME</a></li>
            <li><a href="<c:url value='/carDisplay' />">RENTALS</a></li>
            <li><a href="<c:url value='/about' />">ABOUT</a></li>
            <li><a href="<c:url value='/contact' />">CONTACT</a></li>
        </ul>
        <button class="book-now" onclick="window.location.href='<c:url value='/carDisplay' />'">Book Now</button>
        <div id="profileIconContainer">
            <!-- Show profile icon if user is logged in -->
            <c:if test="${not empty sessionScope.user}">
                <img src="https://static.vecteezy.com/system/resources/previews/036/280/651/non_2x/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-illustration-vector.jpg"
                     alt="Profile"
                     class="profile-icon"
                     onclick="window.location.href='<c:url value='/profile' />'">
            </c:if>
        </div>
    </div>

    <!-- carousel -->
    <div class="carousel">
        <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
          <div class="carousel-inner" id="carouselContent">
            <!-- Carousel items will be injected here by JavaScript -->
          </div>
        </div>
    </div>

    <!-- login-register buttons (only show if not logged in) -->
    <c:if test="${empty sessionScope.user}">
        <div class="login-buttons">
            <button onclick="window.location.href='<c:url value='/login' />'">Login</button>
            <button onclick="window.location.href='<c:url value='/signup' />'">Register</button>
        </div>
    </c:if>

    <!-- Welcome message with user's name if logged in -->
    <c:if test="${not empty sessionScope.user}">
        <div class="welcome-message">
            <h3>Welcome back, ${sessionScope.user.firstName}!</h3>
        </div>
    </c:if>

    <h2>WELCOME TO MEGA CITY CAB</h2>
    <h1>Exquisite Drives for Premium Journeys</h1>

    <!-- Reservation Bar -->
    <div class="reservation-bar">
      <div class="reservation-item">
        <label for="start-date">When to Start</label>
        <input type="date" id="start-date">
      </div>
      <div class="reservation-item">
        <label for="end-date">When to End</label>
        <input type="date" id="end-date">
      </div>
      <div class="reservation-item">
        <label for="vehicle-type">Type</label>
        <select id="vehicle-type">
            <option value="" selected disabled>Select</option>
            <option value="minicar">Minicar</option>
            <option value="hatchback">Hatchback</option>
            <option value="sedan">Sedan</option>
            <option value="luxury">Luxury Car</option>
            <option value="jeep">Jeep</option>
            <option value="sports">Sports Car</option>
            <option value="other">Other</option>
        </select>
      </div>
      <div class="reservation-item">
        <label for="brand">Brand</label>
        <select id="brand">
          <option value="" selected disabled>Select</option>
            <option value="toyota">Toyota</option>
            <option value="honda">Honda</option>
            <option value="hyundai">Hyundai</option>
            <option value="suzuki">Suzuki</option>
            <option value="mitsubishi">Mitsubishi</option>
            <option value="audi">Audi</option>
            <option value="bmw">BMW</option>
            <option value="mercedes">Mercedes Benz</option>
            <option value="other">Other</option>
        </select>
      </div>
      <button class="check-availability">Check Availability</button>
    </div>

    <!-- guidelines -->
    <div class="how-it-works">
      <div class="section-title">
          <button class="badge" onclick="window.location.href='<c:url value='/guidance' />'">GUIDANCE</button>
          <h4>How It Works</h4>
      </div>
      <div class="steps">
          <div class="step">
              <span class="step-number">1</span>
              <div class="icon bg-orange">
                  <i class="bi bi-person-circle"></i>
              </div>
              <p>Sign up Account</p>
          </div>
          <div class="step">
              <span class="step-number">2</span>
              <div class="icon bg-purple">
                  <i class="bi bi-search"></i>
              </div>
              <p>Search your Vehicle</p>
          </div>
          <div class="step">
              <span class="step-number">3</span>
              <div class="icon bg-green">
                  <i class="bi bi-cash"></i>
              </div>
              <p>Pay the Car Rent</p>
          </div>
          <div class="step">
              <span class="step-number">4</span>
              <div class="icon bg-yellow">
                  <i class="bi bi-car-front-fill"></i>
              </div>
              <p>Take Car to Road</p>
          </div>
      </div>
    </div>

    <!-- car section - UPDATED -->
    <section class="popular-cars-section">
        <div class="section-header">
            <span class="badge">POPULAR CARS</span>
            <h4>Most Popular Cars</h4>
        </div>

        <div class="cars-container" id="cars-container">
            <!-- Car cards will be populated from the model -->
            <c:choose>
                <c:when test="${empty cars}">
                    <div class="no-cars-message">
                        <p>No cars available at the moment. Please check back later.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="car" items="${cars}" varStatus="status" begin="0" end="5">
                        <div class="car-card" onclick="window.location.href='<c:url value='/carStructured?carNo=${car.carNo}' />'">
                            <div class="car-image">
                                <c:choose>
                                    <c:when test="${not empty car.images}">
                                        <img src="<c:url value='/images/${car.images}' />" alt="${car.name}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://via.placeholder.com/400x250" alt="${car.name}">
                                    </c:otherwise>
                                </c:choose>
                                <span class="price-tag">Rs.${car.price}/Day</span>
                            </div>
                            <div class="car-content">
                                <h3>${car.name}</h3>
                                <p>${car.aboutCar.length() > 100 ? car.aboutCar.substring(0, 100).concat('...') : car.aboutCar}</p>
                                <div class="features">
                                    <p><i class="fa-solid fa-users"></i> Seat Capacity: ${car.peopleCapacity} People</p>
                                    <p><i class="fa-solid fa-car"></i> Total Doors: ${car.doors} Doors</p>
                                    <p><i class="fa-solid fa-gas-pump"></i> Fuel Tank: ${car.fuelLiters} Liters</p>
                                </div>
                                <button class="rent-btn">Rent Now</button>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <button class="viewmore" onclick="window.location.href='<c:url value='/carDisplay' />'">view more</button>
    </section>

    <!-- car types -->
    <div class="car-types">
      <!-- Badge -->
      <div class="badge-container">
          <span class="badge">CAR TYPES</span>
      </div>

      <!-- Title -->
      <h4 class="section-title">Explore Car Types</h4>

      <!-- Car Type Cards -->
      <div class="car-types-container">
          <div class="car-type-card">
              <img src="https://thumbs.dreamstime.com/b/old-mini-car-small-red-isolated-white-background-30799662.jpg" alt="minicar">
              <p>MiniCar</p>
          </div>
          <div class="car-type-card">
              <img src="https://www.pricelanka.lk/wp-content/uploads/2021/03/Suzuki-Alto.png" alt="Hatchback">
              <p>Hatchback</p>
          </div>
          <div class="car-type-card">
              <img src="https://www.pricelanka.lk/wp-content/uploads/2021/04/Honda-Civic.png" alt="Sedan">
              <p>Sedan</p>
          </div>
          <div class="car-type-card">
              <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC7BnA6yaqz358POd-pXYWDM-2N-UwGixBp3eL50hDUw26nHkHh1jeVU9n9uhnjoYB3go&usqp=CAU" alt="Luxury car">
              <p>Luxury Car</p>
          </div>
          <div class="car-type-card">
              <img src="https://www.jeep.com.lk/content/dam/cross-regional/asean/jeep/common/bhp/lineup/drive_forward/2021_Wrangler_Rubicon_Sting_Gray.jpg.img.500.jpg" alt="jeep">
              <p>Jeep</p>
          </div>
          <div class="car-type-card">
              <img src="https://api.hobbymart.lk/api/assets/product-images/P1734658534008_1.png" alt="Sports Car">
              <p>Sports Car</p>
          </div>
      </div>
    </div>

    <!-- car brands -->
    <div class="car-brands">
        <!-- Badge -->
        <div class="badge-container">
            <span class="badge">BRANDS</span>
        </div>

        <!-- Title -->
        <h4 class="section-title">Explore Premium Car Brands</h4>

        <!-- Car Type Cards -->
        <div class="car-types-container">
            <div class="car-type-card">
                <img src="https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_ogp_001.png" alt="toyota">
                <p>TOYOTA</p>
            </div>
            <div class="car-type-card">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcZ2B7VByimVyejhLrIPRYmWQojpiGiUfMkFq3fXNForthQtgJHJsej_KkXQHGIjTbaOk&usqp=CAU" alt="nissan">
                <p>Nissan</p>
            </div>
            <div class="car-type-card">
                <img src="https://i.pinimg.com/736x/da/9c/a5/da9ca5610b6a94b59294e9cc37657cb1.jpg" alt="honda">
                <p>Honda</p>
            </div>
            <div class="car-type-card">
                <img src="https://logos-world.net/wp-content/uploads/2020/04/BMW-Logo.png" alt="bmw">
                <p>BMW</p>
            </div>
            <div class="car-type-card">
                <img src="https://di-uploads-pod3.dealerinspire.com/vindeversautohausofsylvania/uploads/2018/10/Audi-Logo-Banner.png" alt="audi">
                <p>Audi</p>
            </div>
            <div class="car-type-card">
                <img src="https://thumbs.dreamstime.com/b/mercedes-benz-logo-transparent-background-vector-illustration-german-luxury-commercial-vehicle-automotive-brand-313266429.jpg" alt="benz">
                <p>Mercedes Benz</p>
            </div>
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
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

  <!-- carousel section -->
  <script>
    // carousel images as constants
    const images = [
        'https://i.redd.it/4k-wallpaper-sports-cars-on-track-v0-rug2mqx929sa1.jpg?width=3840&format=pjpg&auto=webp&s=4f0f3bfc079cbbe382648febb3f6119f9a2073bc',
        'https://c4.wallpaperflare.com/wallpaper/397/591/648/audi-r8-car-wallpaper-preview.jpg',
        'https://imagescdn.dealercarsearch.com/DealerImages/11627/27257/fxslide3.jpg',
    ];

    // Get the carousel inner container
    const carouselContent = document.getElementById('carouselContent');

    // Generate carousel items dynamically
    for (let i = 0; i < images.length; i++) {
        const div = document.createElement('div');
        if (i === 0) {
            div.className = 'carousel-item active';
        } else {
            div.className = 'carousel-item';
        }
        div.innerHTML = '<img src="' + images[i] + '" class="d-block w-100" alt="Slide ' + (i + 1) + '">';
        carouselContent.appendChild(div);
    }
  </script>

  <!-- Reservation bar functionality -->
  <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Set minimum date for date inputs to today
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('start-date').min = today;
        document.getElementById('end-date').min = today;

        // When start date changes, ensure end date is not before start date
        document.getElementById('start-date').addEventListener('change', function() {
            const startDate = this.value;
            const endDateInput = document.getElementById('end-date');

            if (startDate) {
                endDateInput.min = startDate;
                // If current end date is before new start date, update it
                if (endDateInput.value && endDateInput.value < startDate) {
                    endDateInput.value = startDate;
                }
            }
        });

        // Check availability button functionality
        document.querySelector('.check-availability').addEventListener('click', function() {
            const startDate = document.getElementById('start-date').value;
            const endDate = document.getElementById('end-date').value;
            const vehicleType = document.getElementById('vehicle-type').value;
            const brand = document.getElementById('brand').value;

            // Validate dates
            if (!startDate || !endDate) {
                alert('Please select both start and end dates');
                return;
            }

            // Create filter object to pass to car display page
            const filters = {
                startDate: startDate,
                endDate: endDate,
                type: vehicleType || '',
                brand: brand || ''
            };

            // Convert to query parameters
            const queryParams = new URLSearchParams(filters).toString();

            // Redirect to car display page with filters
            window.location.href = '<c:url value="/carDisplay" />?' + queryParams;
        });
    });
  </script>
</body>
</html>