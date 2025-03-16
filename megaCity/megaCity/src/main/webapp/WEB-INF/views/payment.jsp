<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Mega City Cab</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            background: white;
            max-width: 350px;
            margin: auto;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #5c87e5;
        }
        .payment-options {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 15px 0;
        }
        .payment-options label {
            display: flex;
            align-items: center;
            gap: 5px;
            cursor: pointer;
        }
        .payment-options img {
            width: 50px;
            height: auto;
        }
        .form-group {
            text-align: left;
            margin: 10px 0;
        }
        .form-group label {
            font-size: 14px;
            color: #5c87e5;
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-row {
            display: flex;
            gap: 10px;
        }
        .form-row .form-group {
            flex: 1;
        }
        .pay-button {
            margin-top: 20px;
            padding: 10px;
            width: 100%;
            font-size: 16px;
            border: none;
            background-color: lightgray;
            color: white;
            cursor: not-allowed;
            border-radius: 5px;
        }
        .pay-button.enabled {
            background-color: #5c87e5;
            cursor: pointer;
        }

        /* Pop-up Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }
        .modal-content {
            background-color: #ffffcc;
            margin: 15% auto;
            padding: 20px;
            border-radius: 10px;
            width: 300px;
            text-align: center;
        }
        .modal-content h3 {
            color: #4a7023;
            margin-bottom: 10px;
        }
        .modal-content button {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .save-bill {
            background-color: #ff9966;
            color: black;
        }
        .view-booking {
            background-color: #d3d3d3;
            color: black;
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
    </style>
</head>
<body>
    <div class="container">
        <h2>Payment</h2>

        <!-- Alert Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/process-payment" method="post" id="paymentForm">
            <input type="hidden" name="bookingNo" value="${booking.bookingNo}">
            <input type="hidden" name="paymentMethod" value="online">

            <div class="payment-options">
                <label>
                    <input type="radio" name="cardType" id="visa" required>
                    <img src="${pageContext.request.contextPath}/images/visa.png" alt="Visa" onerror="this.src='https://placehold.co/50x30?text=VISA'">
                </label>
                <label>
                    <input type="radio" name="cardType" id="mastercard">
                    <img src="${pageContext.request.contextPath}/images/mastercard.png" alt="MasterCard" onerror="this.src='https://placehold.co/50x30?text=MC'">
                </label>
            </div>

            <div class="form-group">
                <label>Cardholder's name</label>
                <input type="text" id="cardholderName" required>
            </div>

            <div class="form-group">
                <label>Card number</label>
                <input type="text" id="cardNumber" maxlength="16" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Expire date</label>
                    <select id="expiryMonth" required>
                        <option value="">MM</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                    </select>
                    <select id="expiryYear" required>
                        <option value="">YYYY</option>
                        <option value="2025">2025</option>
                        <option value="2026">2026</option>
                        <option value="2027">2027</option>
                        <option value="2028">2028</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>CVV</label>
                    <input type="text" id="cvv" maxlength="3" required>
                </div>
            </div>

            <button type="submit" class="pay-button" id="payButton" disabled>Pay Rs. ${booking.totalAmount}</button>
        </form>
    </div>

    <!-- Modal for Payment Success -->
    <div id="paymentModal" class="modal">
        <div class="modal-content">
            <h3>Payment Done!</h3>
            <h3>Booking Successful!</h3>
            <button class="save-bill" onclick="location.href='${pageContext.request.contextPath}/download-bill/${booking.bookingNo}'">Save Your Bill</button>
            <button class="view-booking" onclick="location.href='${pageContext.request.contextPath}/my-bookings'">View Booking</button>
        </div>
    </div>

    <script>
        function validateForm() {
            let visa = document.getElementById("visa").checked;
            let mastercard = document.getElementById("mastercard").checked;
            let name = document.getElementById("cardholderName").value.trim();
            let cardNumber = document.getElementById("cardNumber").value.trim();
            let expiryMonth = document.getElementById("expiryMonth").value;
            let expiryYear = document.getElementById("expiryYear").value;
            let cvv = document.getElementById("cvv").value.trim();
            let payButton = document.getElementById("payButton");

            if ((visa || mastercard) && name !== "" && cardNumber.length === 16 && expiryMonth !== "" && expiryYear !== "" && cvv.length === 3) {
                payButton.disabled = false;
                payButton.classList.add("enabled");
            } else {
                payButton.disabled = true;
                payButton.classList.remove("enabled");
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll("input, select").forEach(input => {
                input.addEventListener("input", validateForm);
            });

            document.querySelectorAll('input[name="cardType"]').forEach(radio => {
                radio.addEventListener("change", validateForm);
            });

            // Handle form submission
            document.getElementById("paymentForm").addEventListener("submit", function (e) {
                e.preventDefault(); // Prevent immediate form submission

                // Show processing modal
                document.getElementById("paymentModal").style.display = "block";

                // Submit the form after a short delay
                setTimeout(function() {
                    // Make sure we're submitting to the correct endpoint
                    document.getElementById("paymentForm").action = "${pageContext.request.contextPath}/process-payment";
                    document.getElementById("paymentForm").submit();
                }, 3000);
            });

            // Close Modal when clicking anywhere outside the box
            window.onclick = function(event) {
                let modal = document.getElementById("paymentModal");
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            };
        });
    </script>
</body>
</html>