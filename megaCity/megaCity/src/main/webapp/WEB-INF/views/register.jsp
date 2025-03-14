<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            margin: 20px;
        }

        .logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo img {
            max-width: 150px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .btn {
            padding: 12px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #45a049;
        }

        .alert {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .login-link {
            text-align: center;
            margin-top: 15px;
        }

        .login-link a {
            color: #4CAF50;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/uploads/logo.png" alt="Logo">
        </div>

        <h2>Create Your Account</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form:form action="${pageContext.request.contextPath}/register" method="post" modelAttribute="user">
            <div class="form-group">
                <label>First Name</label>
                <form:input path="firstName" required="true" placeholder="Enter your first name" class="form-control"/>
            </div>

            <div class="form-group">
                <label>Last Name</label>
                <form:input path="lastName" required="true" placeholder="Enter your last name" class="form-control"/>
            </div>

            <div class="form-group">
                <label>NIC or Passport</label>
                <form:input path="nicOrPassport" required="true" placeholder="Enter your NIC or passport number" class="form-control"/>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <form:input path="phoneNumber" required="true" placeholder="Enter phone number" class="form-control"/>
            </div>

            <div class="form-group">
                <label>Secondary Phone Number (Optional)</label>
                <form:input path="secondaryPhoneNumber" placeholder="Enter secondary phone number" class="form-control"/>
            </div>

            <div class="form-group">
                <label>Address</label>
                <form:input path="address" required="true" placeholder="Enter your address" class="form-control"/>
            </div>

            <div class="form-group">
                <label>Email</label>
                <form:input path="email" type="email" required="true" placeholder="Enter your email" class="form-control"/>
            </div>

            <div class="form-group">
                <label>Password</label>
                <form:password path="password" required="true" placeholder="Enter your password" class="form-control"/>
            </div>

            <button type="submit" class="btn">Register</button>
        </form:form>

        <div class="login-link">
            Already have an account? <a href="${pageContext.request.contextPath}/login">Sign In</a>
        </div>
    </div>
</body>
</html>