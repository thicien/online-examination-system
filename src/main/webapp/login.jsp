<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Online Examination System</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet">
</head>
<body style="background-color: #f4f7f6; font-family: 'Segoe UI', sans-serif;">
    <div class="navbar">
        <div class="logo">OES</div>
        <div>
            <a href="index.jsp">Home</a>
            <a href="register.jsp">Register</a>
        </div>
    </div>

    <div class="form-container">
        <h2 style="text-align:center; color: #2c3e50;">Login</h2>
        
        <% if (request.getParameter("error") != null) { %>
            <p class="error"><%= request.getParameter("error") %></p>
        <% } %>
        <% if (request.getParameter("msg") != null) { %>
            <p class="msg"><%= request.getParameter("msg") %></p>
        <% } %>

        <form action="auth" method="post">
            <input type="hidden" name="action" value="login">
            
            <label>Email or Username (Admin):</label>
            <input type="text" name="email" required>
            
            <label>Password:</label>
            <input type="password" name="password" required>
            
            <button type="submit">Login</button>
        </form>
        
        <div style="text-align: center; margin-top: 15px;">
            <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        </div>
    </div>
    
    <%@ include file="footer.jsp" %>
</body>
</html>
