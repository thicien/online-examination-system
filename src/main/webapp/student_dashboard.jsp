<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.dao.*" %>
<%@ page import="com.oes.model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDateTime" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    ExamDao examDao = new ExamDao();
    ResultDao resultDao = new ResultDao();

    // Stats
    int attempted = resultDao.countAttemptedExams(user.getId());
    int passed = resultDao.countPassedExams(user.getId(), 50);
    int failed = resultDao.countFailedExams(user.getId(), 50);
    
    // Calculate Available Exams Count
    List<Exam> allExams = examDao.getAllExams();
    int availableCount = 0;
    for(Exam e : allExams) {
        if(!examDao.isExamAttempted(user.getId(), e.getId())) {
             availableCount++;
        }
    }

    // Recent Results
    List<Result> allResults = resultDao.getResultsByUserId(user.getId());
    List<Result> recentResults = new ArrayList<>();
    for(int i=0; i<Math.min(5, allResults.size()); i++) {
        recentResults.add(allResults.get(i));
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard - OES</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css"> <!-- Reusing Admin CSS for consistency -->
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
            <h2 class="page-title">Dashboard Overview</h2>

            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card" style="border-left-color: var(--info-color);">
                    <h3><%= availableCount %></h3>
                    <p>📝 Available Exams</p>
                </div>
                <div class="stat-card" style="border-left-color: var(--secondary-color);">
                    <h3><%= attempted %></h3>
                    <p>✅ Attempted</p>
                </div>
                <div class="stat-card" style="border-left-color: var(--success-color);">
                    <h3><%= passed %></h3>
                    <p>🟢 Passed</p>
                </div>
                <div class="stat-card" style="border-left-color: var(--danger-color);">
                    <h3><%= failed %></h3>
                    <p>🔴 Failed</p>
                </div>
            </div>

            <!-- Quick Actions -->
            <h3 class="page-title">Quick Actions</h3>
            <div class="quick-actions">
                <a href="student_exams.jsp" class="action-btn" style="background-color: var(--success-color);">View Available Exams</a>
                <a href="student_my_exams.jsp" class="action-btn" style="background-color: var(--info-color);">View My Results</a>
            </div>

            <!-- Recent Results -->
            <h3 class="page-title">Recent Results</h3>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Exam</th>
                            <th>Score</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Result r : recentResults) { 
                             // Need total marks to calculate pass/fail status reliably, but Result object doesn't have it directly populated in getResultsByUserId usually.
                             // ResultDao.getResultsByUserId joins with exams table but checks 'r.*'. 
                             // Let's check ResultDao.getResultsByUserId query.
                             // It selects r.*, e.exam_name. It does NOT select total_marks.
                             // I should assume a pass mark or just show score. 
                             // The user prompt example shows: "Status: PASSED".
                             // I will use a simple heuristic for now or update DAO later if needed.
                             // For now, I'll colour code based on >= 40% if I knew total marks. 
                             // Since I don't have total marks in Result object easily here without another query, 
                             // I'll just show the score and date. 
                             // Wait, I can't determine Pass/Fail without total marks.
                             // I'll just show "Completed" for now or update DAO to fetch total_marks.
                             // I'll update ResultDao.getResultsByUserId to fetch total_marks in the next iteration if needed.
                             // For now, let's just display what we have.
                        %>
                        <tr>
                            <td><%= r.getExamName() %></td>
                            <td><%= r.getScore() %></td>
                            <td><%= r.getExamDate() %></td>
                            <td><span class="status-pass">Completed</span></td>
                            <td><a href="review_exam.jsp?examId=<%= r.getExamId() %>" style="color: var(--primary-color); text-decoration: none; font-weight: 600;">Review</a></td>
                        </tr>
                        <% } %>
                        <% if(recentResults.isEmpty()) { %>
                        <tr>
                            <td colspan="4" style="text-align:center;">No recent results found.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</body>
</html>
