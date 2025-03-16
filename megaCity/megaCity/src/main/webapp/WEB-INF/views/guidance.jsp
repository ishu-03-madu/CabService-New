<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guidelines</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
  }

  /* Background styling */
  .hero {
    height: auto;
    background-color: white;
  }

  /* Navigation bar styling */
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

  .logo-link{
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

  /* Book Now Button */
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

.content h2{
    margin-top: 10px;
}
        .guideline {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            margin-left: 15%;
        }
        .circle {
            width: 30px;
            height: 30px;
            border: 2px solid orange;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-right: 10px;
        }

        .close-button {
            position: absolute;
            top: 70px;
            right: 10px;
            background: red;
            color: white;
            border: none;
            padding: 5px 10px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }
        .close-button:hover {
            background: darkred;
        }

        /* footer */
      .footer {
        margin-top: 100px;
        background: url(https://media.istockphoto.com/id/927422762/vector/silhouette-of-a-automotive-car.jpg?s=612x612&w=0&k=20&c=sg301t-Njw4z9ev_KHLto-63KcYS-L4lhI6qtmxKBhk=);
        background-size: cover;
        background-repeat: no-repeat;
        background-position: center;
        color: white;
        padding: 40px 20px;
        text-align: center;
        /* border-top-left-radius: 30%;
        border-top-right-radius: 30%;  */
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
    <div class="hero">
        <!-- Navigation Bar -->
        <div class="navbar">
            <div class="logo">
                <img src="uploads/logo.png" class="logo-icon">
                <a href="Home.jsp" class="logo-link">Mega City Cab</a>
            </div>
            <ul>
                <li><a href="Home.jsp">HOME</a></li>
                <li><a href="CarDisplay.jsp">RENTALS</a></li>
                <li><a href="About.jsp">ABOUT</a></li>
                <li><a href="Contact.jsp">CONTACT</a></li>
            </ul>
            <button class="book-now" onclick="window.location.href='CarDisplay.jsp'">Book Now</button>
            <div id="profileIconContainer">
                <%
                    // Check if user is logged in using session
                    Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
                    if (isLoggedIn != null && isLoggedIn) {
                %>
                    <img src="https://static.vecteezy.com/system/resources/previews/036/280/651/non_2x/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-illustration-vector.jpg"
                         alt="Profile"
                         class="profile-icon"
                         onclick="window.location.href='Profile.jsp'">
                <%
                    }
                %>
            </div>
        </div>

        <div class="content">
            <button class="close-button" onclick="window.location.href='Home.jsp'">X</button>
            <h2 class="text-center">Guideline for Users</h2>
            <p class="text-center">Welcome to our car rental service! To ensure a smooth and hassle-free experience, please follow these guidelines when booking a vehicle.</p>

            <div class="guideline">
                <div class="circle">1</div>
                <div>
                    <h5>Account Registration</h5>
                    <ul>
                        <li>Provide accurate personal information for verification using a valid email address.</li>
                        <li>Secure your account with a strong password and log in to the website.</li>
                    </ul>
                </div>
            </div>

            <div class="guideline">
                <div class="circle">2</div>
                <div>
                    <h5>Booking a Vehicle</h5>
                    <ul>
                        <li>Go to Book Now and filter or select a vehicle according to your preferences.</li>
                        <li>Book the vehicle for the desired period. If you want our trusted driver with the vehicle, include.</li>
                    </ul>
                </div>
            </div>

            <div class="guideline">
                <div class="circle">3</div>
                <div>
                    <h5>Payment & Charges</h5>
                    <ul>
                        <li>Payment can be made online or at the rental location.</li>
                        <li>There is a daily distance limit of 100km and Rs.100 will be charged for each additional kilometer.</li>
                        <li>Late return charges per day are Rs. 500.</li>
                        <li>Security deposits (Rs.5000) will be refunded after the vehicle is returned in good condition.</li>
                    </ul>
                </div>
            </div>

            <div class="guideline">
                <div class="circle">4</div>
                <div>
                    <h5>Vehicle Pickup & Return</h5>
                    <ul>
                        <li>Inspect the vehicle for any existing damages and report them before use.</li>
                        <li>Return the car at the agreed time and location to avoid late fees.</li>
                    </ul>
                </div>
            </div>

            <div class="guideline">
                <div class="circle">5</div>
                <div>
                    <h5>Usage & Responsibility</h5>
                    <ul>
                        <li>Follow all traffic laws and drive responsibly.</li>
                        <li>Do not allow unauthorized drivers to use the vehicle.</li>
                        <li>In case of accidents or breakdowns, contact our support team immediately.</li>
                    </ul>
                </div>
            </div>

            <p class="text-center">By following these guidelines, you can enjoy a seamless and enjoyable car rental experience. If you have any questions, feel free to reach out to our customer support team (+94 12345678). Safe travels!</p>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <div class="logo">MEGA CITY CAB</div>
            <div class="slogan">Cab Service Company</div>
            <div class="menu">
                <div class="menu-section">
                    <a href="Terms.jsp">Terms & Conditions</a>
                    <a href="Blog.jsp">Blog</a>
                </div>
                <div class="menu-section">
                    <a href="Feedback.jsp">Feedback</a>
                    <a href="Support.jsp">Support</a>
                </div>
                <div class="menu-section">
                    <a href="About.jsp">About Us</a>
                    <a href="Contact.jsp">Contact Us</a>
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
</body>
</html>