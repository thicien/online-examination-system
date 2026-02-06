<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Online Examination System</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="logo">OES</div>
        <div>
            <a href="register.jsp">Register</a>
        </div>
    </div>

    <div class="form-container">
        <h2 style="text-align:center;">Login</h2>
        
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
    </div>
</body>
</html>
