<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Online Examination System</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="logo">OES</div>
        <div>
            <a href="index.jsp">Login</a>
        </div>
    </div>

    <div class="form-container">
        <h2 style="text-align:center;">Student Registration</h2>
        
        <% if (request.getParameter("error") != null) { %>
            <p class="error"><%= request.getParameter("error") %></p>
        <% } %>

        <form action="auth" method="post">
            <input type="hidden" name="action" value="register">
            
            <label>Full Name:</label>
            <input type="text" name="name" required>
            
            <label>Email:</label>
            <input type="email" name="email" required>
            
            <label>Password:</label>
            <input type="password" name="password" required>
            
            <button type="submit">Register</button>
        </form>
        <div style="text-align: center; margin-top: 15px;">
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </div>
    </div>
    
    <%@ include file="footer.jsp" %>
</body>
</html>
