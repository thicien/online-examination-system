<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Result</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="logo">OES Result</div>
        <div>
            <a href="student_dashboard.jsp">Dashboard</a>
            <a href="auth?action=logout">Logout</a>
        </div>
    </div>

    <div class="container" style="text-align: center; margin-top: 50px;">
        <div class="card" style="display: inline-block; width: 400px;">
            <h2 style="color: #28a745;">Exam Submitted!</h2>
            
            <h1>Your Score</h1>
            <div style="font-size: 48px; color: #007BFF; font-weight: bold;">
                <%= request.getAttribute("score") %> / <%= request.getAttribute("total") %>
            </div>
            
            </div>
            
            <br>
            <a href="student_dashboard.jsp" class="button" style="background: #007BFF; color: white; padding: 10px 20px; border-radius: 5px;">Back to Dashboard</a>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
