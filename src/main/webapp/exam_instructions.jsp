<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.dao.ExamDao" %>
<%@ page import="com.oes.model.Exam" %>
<%
    String idStr = request.getParameter("examId");
    if (idStr == null) {
        response.sendRedirect("student_exams.jsp");
        return;
    }
    int examId = Integer.parseInt(idStr);
    ExamDao dao = new ExamDao();
    Exam exam = dao.getExamById(examId);
    if (exam == null) {
        response.sendRedirect("student_exams.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Instructions - OES</title>
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
            <h2 class="page-title">Exam Instructions</h2>
            
            <div class="card">
                <h3><%= exam.getName() %></h3>
                <p><strong>Duration:</strong> <%= exam.getDuration() %> minutes</p>
                <p><strong>Total Marks:</strong> <%= exam.getTotalMarks() %></p>
                
                <hr>
                
                <h4>Please read the following instructions carefully:</h4>
                <ul style="line-height: 1.6;">
                    <li>The exam has a strict time limit of <strong><%= exam.getDuration() %> minutes</strong>.</li>
                    <li>There are multiple questions, and each question has one correct answer.</li>
                    <li>Do not refresh the page during the exam.</li>
                    <li>The exam will auto-submit when the timer ends.</li>
                    <li>Ensure you have a stable internet connection.</li>
                    <li>Click the "Start Exam" button below when you are ready.</li>
                </ul>
                
                <div style="margin-top: 30px; text-align: center;">
                    <a href="exam?action=take&id=<%= exam.getId() %>" class="action-btn" style="padding: 15px 30px; font-size: 1.1rem;">Start Exam</a>
                    <br><br>
                    <a href="student_exams.jsp" style="color: grey;">Cancel</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
