<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.dao.*" %>
<%@ page import="com.oes.model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    ExamDao examDao = new ExamDao();
    List<Exam> exams = examDao.getAllExams();
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Available Exams - OES</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet">
</head>
<body>

    <!-- Sidebar -->
    <%@ include file="student_sidebar.jsp" %>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <%@ include file="student_header.jsp" %>

        <!-- Content Area -->
        <div class="content-area">
            <h2 class="page-title">Available Exams</h2>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Exam Name</th>
                            <th>Duration</th>
                            <th>Total Marks</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Exam e : exams) { 
                            boolean isAttempted = examDao.isExamAttempted(user.getId(), e.getId());
                            
                            LocalDateTime start = (e.getStartTime() != null && !e.getStartTime().isEmpty()) ? LocalDateTime.parse(e.getStartTime()) : null;
                            LocalDateTime end = (e.getEndTime() != null && !e.getEndTime().isEmpty()) ? LocalDateTime.parse(e.getEndTime()) : null;
                            
                            boolean isBefore = (start != null) && now.isBefore(start);
                            boolean isAfter = (end != null) && now.isAfter(end);
                            boolean isActive = !isAttempted && !isBefore && !isAfter;
                        %>
                        <tr>
                            <td><%= e.getName() %></td>
                            <td><%= e.getDuration() %> mins</td>
                            <td><%= e.getTotalMarks() %></td>
                            <td><%= (start != null) ? start.format(formatter).replace("T", " ") : "Anytime" %></td>
                            <td><%= (end != null) ? end.format(formatter).replace("T", " ") : "Anytime" %></td>
                            <td>
                                <% if (isAttempted) { %>
                                    <button class="btn-sm" style="background-color: var(--secondary-color); cursor: not-allowed;" disabled>Attempted</button>
                                <% } else if (isBefore) { %>
                                    <button class="btn-sm" style="background-color: var(--warning-color); cursor: not-allowed;" disabled>Coming Soon</button>
                                <% } else if (isAfter) { %>
                                    <button class="btn-sm" style="background-color: var(--danger-color); cursor: not-allowed;" disabled>Expired</button>
                                <% } else { %>
                                    <a href="exam_instructions.jsp?examId=<%= e.getId() %>" class="btn-sm" style="background-color: var(--success-color);">Start Exam</a>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                         <% if(exams.isEmpty()) { %>
                        <tr>
                            <td colspan="6" style="text-align:center;">No exams enabled by admin.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
