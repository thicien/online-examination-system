<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.dao.ExamDao" %>
<%@ page import="com.oes.model.Exam" %>
<%@ page import="com.oes.model.Admin" %>
<%@ page import="java.util.List" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    ExamDao examDao = new ExamDao();
    List<Exam> exams = examDao.getAllExams();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="logo">OES Admin</div>
        <div>
            Welcome, <%= admin.getUsername() %>
            <a href="auth?action=logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>Manage Exams</h2>
        
        <div style="margin-bottom: 20px;">
            <a href="create_exam.jsp" class="button" style="background: #007BFF; color: white; padding: 10px; border-radius: 5px;">+ Create New Exam</a>
        </div>

        <% if (request.getParameter("msg") != null) { %>
            <p class="msg"><%= request.getParameter("msg") %></p>
        <% } %>

        <table>
            <tr>
                <th>ID</th>
                <th>Exam Name</th>
                <th>Duration (min)</th>
                <th>Total Marks</th>
                <th>Actions</th>
            </tr>
            <% for (Exam e : exams) { %>
            <tr>
                <td><%= e.getId() %></td>
                <td><%= e.getName() %></td>
                <td><%= e.getDuration() %></td>
                <td><%= e.getTotalMarks() %></td>
                <td>
                    <a href="add_question.jsp?examId=<%= e.getId() %>">Add Questions</a> | 
                    <a href="admin?action=deleteExam&id=<%= e.getId() %>" style="color: red;" onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
