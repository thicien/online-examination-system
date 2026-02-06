<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Exam</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="logo">OES Admin</div>
        <div>
            <a href="admin_dashboard.jsp">Dashboard</a>
            <a href="auth?action=logout">Logout</a>
        </div>
    </div>

    <div class="form-container">
        <h2 style="text-align:center;">Create New Exam</h2>
        
        <form action="admin" method="post">
            <input type="hidden" name="action" value="addExam">
            
            <label>Exam Name:</label>
            <input type="text" name="examName" required>
            
            <label>Duration (minutes):</label>
            <input type="number" name="duration" required>
            
            <label>Total Marks:</label>
            <input type="number" name="totalMarks" required>
            
            <button type="submit">Create Exam</button>
        </form>
    </div>
</body>
</html>
