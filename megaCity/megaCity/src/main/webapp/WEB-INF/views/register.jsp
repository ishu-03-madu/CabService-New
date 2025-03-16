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
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background: url('uploads/loginba.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .registration-container {
            display: flex;
            width: 80%;
            max-width: 1200px;
            background: #fff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            overflow: hidden;
            margin: 10px;
        }

        .logo img {
            width: 100px;
            height: 100px;
            margin-left: 40%;
        }

        .form-section {
            flex: 1;
            padding: 30px;
            position: relative;
        }

        .close-button {
            position: absolute;
            top: 10px;
            left: 10px;
            width: 30px;
            height: 30px;
            background-color: #bd9e9e;
            border: 1px solid #ddd;
            border-radius: 50%;
            text-align: center;
            line-height: 30px;
            font-size: 28px;
            color: #333;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
        }

        .close-button:hover {
            background-color: #b8b1b1;
        }

        .form-section h2 {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
            font-family: 'Times New Roman', Times, serif;
        }

        .progress-bar {
            display: flex;
            justify-content: space-around;
            margin: 20px 0;
            list-style: none;
            padding: 0;
        }

        .progress-bar li {
            text-align: center;
            width: 25%;
        }

        .progress-bar li span {
            display: inline-block;
            width: 30px;
            height: 30px;
            line-height: 30px;
            background: #ddd;
            border-radius: 50%;
            margin-bottom: 5px;
        }

        .progress-bar li.active span {
            background: #ff5b5b;
            color: black;
        }

        .progress-bar li.active {
            color: #661d1d;
        }

        form {
            display: none;
        }

        form.active {
            display: block;
        }

        label {
            display: block;
            margin-bottom: 10px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        button {
            background: #fd7878;
            color: black;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }

        button:hover {
            background: #ff5b5b;
        }

        .forlogin {
            text-align: right;
            font-size: 14px;
        }
        .forlogin a {
            color: #007bff;
        }

        .image-section {
            flex: 1;
            background: url('https://i.etsystatic.com/40485572/r/il/66fbdb/4608947253/il_fullxfull.4608947253_a73t.jpg') no-repeat center center;
            background-size: cover;
            border-top-left-radius: 50%;
        }
    </style>
</head>
<body>
    <div class="registration-container">
        <div class="form-section">
            <div class="close-button" onclick="window.location.href='${pageContext.request.contextPath}/home'">×</div>
            <div class="logo">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo">
            </div>

            <h2>Create Your Account</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form:form action="${pageContext.request.contextPath}/register" method="post" modelAttribute="user" class="active">
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

            <div class="forlogin">
                Already have an account? <a href="${pageContext.request.contextPath}/login">Sign In</a>
            </div>
        </div>
        <div class="image-section"></div>
    </div>
</body>
</html>