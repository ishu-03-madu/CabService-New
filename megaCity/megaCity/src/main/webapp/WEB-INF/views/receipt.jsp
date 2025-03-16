<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receipt - Mega City Cab</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        .logo {
            display: flex;
            justify-content: center;
            color: #ff4d4d;
            text-shadow: 4px 4px 8px rgba(0, 0, 0, 0.5);
            font-size: 30px;
            font-weight: bold;
            font-family: cursive;
            font-style: italic;
            text-transform: uppercase;
        }
        .logo img{
            width: 70px;
            height: 70px;
        }
        .logo span{
            margin-top: 10px;
        }
        #border{
            height: 150px;
            width: 800px;
            margin-top: -50px;
        }
        h3{
            margin-left: 500px;
            margin-top: -30px;
            color: #6c0303;
        }
        .form-group {
            display: flex;
            justify-content: space-between;
            margin: 10px 0;
            align-items: center;
        }
        .form-group input {
            width: 60%;
            padding: 5px;
            border: 1px solid rgb(244, 247, 244);
        }
        .form-group input[readonly] {
            cursor: not-allowed;
            background-color: #f9f9f9;
        }
        .payment-method {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
        }
        .total-bill {
            font-weight: bold;
            margin-top: 20px;
            margin-left: 60%;
        }
        .terms {
            width: 530px;
            color: red;
            font-size: 12px;
            margin-top: 10px;
            margin-left: 15%
        }
        .pay-button {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            background-color: #5c87e5;
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }
        .pay-button:hover {
            background-color: #4a70c9;
        }

        .billfooter {
            background-color: white;
            text-align: center;
            padding: 10px 0;
            font-size: 16px;
            color: black;
        }
        .billfooter hr {
            border: 0;
            height: 8px;
            background-color: darkred;
            margin-bottom: 10px;
        }
        .billfooter p {
            margin: 5px 0;
            line-height: 1.5;
        }
        .billfooter a{
            text-decoration: none;
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
        <div class="logo">
            <img src="${pageContext.request.contextPath}/uploads/logo.png" alt="Mega City Cab" width="50" onerror="this.style.display='none'">
            <span>Mega City Cab</span>
        </div>
        <img src="${pageContext.request.contextPath}/uploads/border.png" alt="" id="border" onerror="this.style.display='none'">
        <h3>--| RECEIPT |--</h3>

        <!-- Alert Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/payment" method="post">
            <input type="hidden" name="bookingNo" value="${booking.bookingNo}">
            <input type="hidden" name="carNo" value="${booking.carNo}">
            <input type="hidden" name="startDate" value="${booking.startDate}">
            <input type="hidden" name="endDate" value="${booking.endDate}">
            <input type="hidden" name="withDriver" value="${booking.withDriver}">
            <input type="hidden" name="totalAmount" value="${booking.totalAmount}">
            <input type="hidden" name="message" value="${booking.message}">

            <div class="form-group">
                <label>Booking no -</label>
                <input type="text" value="${booking.bookingNo}" readonly>
            </div>
            <div class="form-group">
                <label>Car no -</label>
                <input type="text" value="${booking.carNo}" readonly>
            </div>
            <div class="form-group">
                <label>Car name -</label>
                <input type="text" value="${car.name} (${car.brand})" readonly>
            </div>
            <div class="form-group">
                <label>Customer NIC or Passport -</label>
                <input type="text" value="${sessionScope.user.nicOrPassport}" readonly>
            </div>
            <div class="form-group">
                <label>Start date -</label>
                <input type="text" value="${booking.startDate}" readonly>
            </div>
            <div class="form-group">
                <label>End date -</label>
                <input type="text" value="${booking.endDate}" readonly>
            </div>
            <div class="form-group">
                <label>Destination -</label>
                <input type="text" name="destination" value="${booking.destination}" placeholder="Enter your destination">
            </div>
            <div class="form-group">
                <label>Driver Cost -</label>
                <input type="text" value="Rs. ${booking.driverCost}" readonly>
            </div>
            <div class="form-group">
                <label>Refundable deposit -</label>
                <input type="text" value="Rs. ${booking.refundableAmount}" readonly>
            </div>

            <div class="payment-method">
                <label>Payment Method</label>
                <label><input type="radio" name="paymentMethod" id="onlinePayment" value="online" required> Online Payment</label>
                <label><input type="radio" name="paymentMethod" id="cashPayment" value="cash"> Cash Payment</label>
            </div>

            <div class="total-bill">
                <label>Total Bill</label>
                <input type="text" value="Rs. ${booking.totalAmount}" readonly>
            </div>

            <button type="submit" class="pay-button" id="continueToPayment">Continue to Payment</button>
        </form>

        <div class="billfooter">
            <hr>
            <p><strong>Telephone:</strong> 0112345678 / 0112876543  |
               <strong>Address:</strong> 26/7 Dark Road, Kirulapana, Colombo</p>
            <p><strong>Email:</strong> <a href="mailto:info@megacitycab.com">info@megacitycab.com</a>  |
               <a href="http://www.megacitycab.lk" target="_blank">www.megacitycab.lk</a></p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const onlinePayment = document.getElementById('onlinePayment');
            const cashPayment = document.getElementById('cashPayment');
            const continueBtn = document.getElementById('continueToPayment');
            const form = document.querySelector('form');

            // When online payment is selected
            onlinePayment.addEventListener('change', function() {
                if (this.checked) {
                    continueBtn.textContent = "Proceed to Online Payment";
                    form.action = "${pageContext.request.contextPath}/payment";
                }
            });

            // When cash payment is selected
            cashPayment.addEventListener('change', function() {
                if (this.checked) {
                    continueBtn.textContent = "Confirm Cash Payment";
                    form.action = "${pageContext.request.contextPath}/process-payment";
                }
            });

            // Set default selection to online payment
            if (onlinePayment) {
                onlinePayment.checked = true;
                continueBtn.textContent = "Proceed to Online Payment";
                form.action = "${pageContext.request.contextPath}/payment";
            }
        });
    </script>
</body>
</html>