<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.dao.*" %>
<%@ page import="com.oes.model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    ResultDao resultDao = new ResultDao();
    ExamDao examDao = new ExamDao();
    List<Result> myResults = resultDao.getResultsByUserId(user.getId());
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Exams - OES</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
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
            <h2 class="page-title">My Exam History</h2>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Exam Name</th>
                            <th>Date Attempted</th>
                            <th>Score</th>
                            <th>Percentage</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Result r : myResults) { 
                            // Fetch exam to get total marks for percentage/status
                            Exam exam = examDao.getExamById(r.getExamId());
                            int totalMarks = (exam != null) ? exam.getTotalMarks() : 100; // Fallback
                            double percentage = (double) r.getScore() / totalMarks * 100;
                            boolean isPass = percentage >= 50; // Assuming 50% pass
                        %>
                        <tr>
                            <td><%= r.getExamName() %></td>
                            <td><%= r.getExamDate() %></td>
                            <td><%= r.getScore() %> / <%= totalMarks %></td>
                            <td><%= String.format("%.2f", percentage) %>%</td>
                            <td>
                                <% if(isPass) { %>
                                    <span class="status-pass">Passed</span>
                                <% } else { %>
                                    <span class="status-fail">Failed</span>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                         <% if(myResults.isEmpty()) { %>
                        <tr>
                            <td colspan="5" style="text-align:center;">No exams attempted yet.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
