<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Question</title>
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

    <div class="form-container" style="max-width: 600px;">
        <h2 style="text-align:center;">Add Question to Exam ID: <%= request.getParameter("examId") %></h2>
        
        <% if (request.getParameter("msg") != null) { %>
            <p class="msg"><%= request.getParameter("msg") %></p>
        <% } %>

        <form action="admin" method="post">
            <input type="hidden" name="action" value="addQuestion">
            <input type="hidden" name="examId" value="<%= request.getParameter("examId") %>">
            
            <label>Question Text:</label>
            <input type="text" name="questionText" required>
            
            <div style="display: flex; gap: 10px;">
                <div style="flex: 1;">
                    <label>Option A:</label>
                    <input type="text" name="optionA" required>
                </div>
                <div style="flex: 1;">
                    <label>Option B:</label>
                    <input type="text" name="optionB" required>
                </div>
            </div>
            
            <div style="display: flex; gap: 10px;">
                <div style="flex: 1;">
                    <label>Option C:</label>
                    <input type="text" name="optionC" required>
                </div>
                <div style="flex: 1;">
                    <label>Option D:</label>
                    <input type="text" name="optionD" required>
                </div>
            </div>
            
            <label>Correct Option:</label>
            <select name="correctOption">
                <option value="A">Option A</option>
                <option value="B">Option B</option>
                <option value="C">Option C</option>
                <option value="D">Option D</option>
            </select>
            
            <button type="submit">Add Question</button>
        </form>
    </div>
</body>
</html>
