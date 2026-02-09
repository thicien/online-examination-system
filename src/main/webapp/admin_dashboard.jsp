
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.dao.*" %>
<%@ page import="com.oes.model.*" %>
<%@ page import="java.util.List" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    UserDao userDao = new UserDao();
    ExamDao examDao = new ExamDao();
    QuestionDao questionDao = new QuestionDao();
    ResultDao resultDao = new ResultDao();

    int userCount = userDao.getUserCount();
    int examCount = examDao.getExamCount();
    int questionCount = questionDao.getQuestionCount();
    int resultCount = resultDao.getResultCount();
    
    List<Result> recentResults = resultDao.getRecentActivity(5);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - OES</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet">
</head>
<body>

    <!-- Sidebar -->
    <%@ include file="admin_sidebar.jsp" %>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <%@ include file="admin_header.jsp" %>

        <!-- Content Area -->
        <div class="content-area">
            <h2 class="page-title">Dashboard Overview</h2>

            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <h3><%= userCount %></h3>
                    <p>Total Users</p>
                </div>
                <div class="stat-card">
                    <h3><%= examCount %></h3>
                    <p>Total Exams</p>
                </div>
                <div class="stat-card">
                    <h3><%= questionCount %></h3>
                    <p>Questions</p>
                </div>
                <div class="stat-card">
                    <h3><%= resultCount %></h3>
                    <p>Results Published</p>
                </div>
            </div>

            <h3 class="page-title">Quick Actions</h3>
            <div class="quick-actions">
                <a href="admin_exams.jsp" class="action-btn">+ Add Exam</a>
                <a href="admin_questions.jsp" class="action-btn">+ Add Question</a>
                <a href="admin_results.jsp" class="action-btn">View Results</a>
            </div>

            <h3 class="page-title">Recent Activity</h3>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Student</th>
                            <th>Exam</th>
                            <th>Score</th>
                            <th>Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Result r : recentResults) { 
                            boolean isPass = r.getScore() >= 40; // Assuming 40% pass for color coding example
                        %>
                        <tr>
                            <td><%= r.getExamName().split(" - ")[0] %></td> <!-- Hack extraction from DAO string construction -->
                            <td><%= r.getExamName().split(" - ")[1] %></td>
                            <td><%= r.getScore() %></td>
                            <td><%= r.getExamDate() %></td>
                            <td><span class="<%= isPass ? "status-pass" : "status-fail" %>"><%= isPass ? "Pass" : "Fail" %></span></td>
                        </tr>
                        <% } %>
                        <% if(recentResults.isEmpty()) { %>
                        <tr>
                            <td colspan="5" style="text-align:center;">No recent activity found.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div> <!-- Close content-area -->
        <%@ include file="footer.jsp" %>
    </div> <!-- Close main-content -->
</body>

</body>
</html>
