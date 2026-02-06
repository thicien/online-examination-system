<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.dao.ExamDao" %>
<%@ page import="com.oes.dao.ResultDao" %>
<%@ page import="com.oes.model.Exam" %>
<%@ page import="com.oes.model.User" %>
<%@ page import="com.oes.model.Result" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    ExamDao examDao = new ExamDao();
    List<Exam> exams = examDao.getAllExams();
    
    ResultDao resultDao = new ResultDao();
    List<Result> myResults = resultDao.getResultsByUserId(user.getId());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="logo">OES Student</div>
        <div>
            Welcome, <%= user.getName() %>
            <a href="auth?action=logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>Available Exams</h2>
        
        <table>
            <tr>
                <th>Exam Name</th>
                <th>Duration (min)</th>
                <th>Total Marks</th>
                <th>Action</th>
            </tr>
            <% for (Exam e : exams) { %>
            <tr>
                <td><%= e.getName() %></td>
                <td><%= e.getDuration() %></td>
                <td><%= e.getTotalMarks() %></td>
                <td>
                    <a href="exam?action=take&id=<%= e.getId() %>" class="button" style="background: #28a745; color: white; padding: 5px 10px; border-radius: 4px;">Start Exam</a>
                </td>
            </tr>
            <% } %>
        </table>

        <h2>My Results</h2>
        <table>
            <tr>
                <th>Exam</th>
                <th>Score</th>
                <th>Date</th>
            </tr>
            <% for (Result r : myResults) { %>
            <tr>
                <td><%= r.getExamName() %></td>
                <td><%= r.getScore() %></td>
                <td><%= r.getExamDate() %></td>
            </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
