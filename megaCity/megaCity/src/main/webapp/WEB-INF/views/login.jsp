<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign In</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      display: flex;
      min-height: 100vh;
      align-items: center;
      justify-content: center;
      background: url(${pageContext.request.contextPath}/uploads/loginba.jpg) no-repeat center center fixed;
      background-size: cover;
    }

    .login-container {
      display: flex;
      width: 80%;
      max-width: 1200px;
      background: #fff;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
      border-radius: 10px;
      overflow: hidden;
      position: relative;
    }

    .close-button {
      position: absolute;
      top: 10px;
      right: 10px;
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

    .login-container .image-section {
      flex: 1;
      background: url('https://i.pinimg.com/736x/50/83/29/5083293978d1a160036a12a258e59fea.jpg') no-repeat center center;
      background-size: cover;
      border-top-right-radius: 30%;
    }

    .login-container .form-section {
      flex: 1;
      padding: 40px;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }

    .form-section .logo {
      text-align: center;
      margin-bottom: 20px;
    }

    .form-section .logo img {
      width: 100px;
      height: 100px;
    }

    .form-section h2 {
      text-align: center;
      font-size: 28px;
      font-family: 'Times New Roman', Times, serif;
      margin-bottom: 30px;
      color: #333;
    }

    .form-section form {
      display: flex;
      flex-direction: column;
      gap: 15px;
    }

    .form-section input[type="email"],
    .form-section input[type="password"],
    .form-section input[type="text"] {
      width: 100%;
      padding: 12px;
      font-size: 14px;
      border: 1px solid #ddd;
      border-radius: 5px;
    }

    .form-section button {
      padding: 12px;
      font-size: 16px;
      background-color: #555;
      color: rgb(242, 231, 171);
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.2s ease-in-out;
    }

    .form-section button:hover {
      background-color: #3d3d3d;
    }

    .form-section .forgot-password {
      text-align: right;
    }

    .form-section .forgot-password a {
      font-size: 14px;
      color: #007bff;
      text-decoration: none;
    }

    .form-section .forgot-password a:hover {
      text-decoration: underline;
    }

    .form-section .other-options {
      text-align: center;
      margin-top: 15px;
    }

    .form-section a {
      color: #007bff;
      text-decoration: none;
    }

    .form-section .other-options a:hover {
      text-decoration: underline;
    }

    .form-section .google-signin {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      margin-top: 10px;
      padding: 12px;
      text-align: center;
      background-color: #4285F4;
      color: rgb(242, 231, 171);
      font-size: 14px;
      border-radius: 5px;
      text-decoration: none;
      cursor: pointer;
    }

    .form-section .google-signin:hover {
      background-color: #5476ac;
    }

    .form-section .google-signin img {
      width: 20px;
      height: 20px;
      border-radius: 50%;
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

  <div class="login-container">
    <div class="close-button" onclick="window.location.href='${pageContext.request.contextPath}/home'">&times;</div>
    <div class="image-section"></div>
    <div class="form-section">
      <div class="logo">
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo">
      </div>
      <h2>Welcome to Mega City Cab</h2>

      <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
      </c:if>

      <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
      </c:if>

      <form action="${pageContext.request.contextPath}/login" method="post">
        <label>
          <input type="email" id="email" name="email" placeholder="Enter your Email or NIC" required>
        </label>
        <label>
          <input type="password" id="password" name="password" placeholder="Password" required>
        </label>
        <div class="forgot-password">
          <a href="${pageContext.request.contextPath}/forgot-password">Forgot password?</a>
        </div>
        <button type="submit">Sign In</button>
        <div class="other-options">
          <p>or</p>
          <a href="${pageContext.request.contextPath}/oauth2/google" class="google-signin">
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJQ9p0kwWYIU-O7dnjXUwIBnxItQb08fMMBQ&s" alt="Google Logo">
            Sign in with Google
          </a>
          <p>Don't have an account? <a href="${pageContext.request.contextPath}/signup">Create Account</a></p>
        </div>
      </form>
    </div>
  </div>

</body>
</html>