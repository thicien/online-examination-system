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
    <style>
        body {
            display: block !important; /* Override admin.css flex layout */
            margin: 0 !important;
            padding: 0 !important;
            width: 100vw;
            overflow-x: hidden;
        }
        .main-content {
            width: 100% !important;
            margin: 0 !important;
            padding: 0 !important;
        }
        .main-footer {
            width: 100% !important;
            margin-right: 0 !important;
            margin-left: 0 !important;
        }
    </style>
</head>
<body>

    <!-- Sidebar Removed for Focus Mode -->
    
    <!-- Main Content -->
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
                    <% if (request.getAttribute("error") != null) { %>
                        <p style="color: red; margin-bottom: 10px;"><%= request.getAttribute("error") %></p>
                    <% } %>

                    <form action="exam" method="post">
                        <input type="hidden" name="action" value="verifyPasswordAndStart">
                        <input type="hidden" name="id" value="<%= exam.getId() %>">
                        
                        <% if (exam.getPassword() != null && !exam.getPassword().trim().isEmpty()) { %>
                        <div style="margin-bottom: 15px;">
                            <label style="font-weight: bold; display: block; margin-bottom: 5px;">Enter Exam Password:</label>
                            <input type="text" name="password" required placeholder="Password is on your dashboard" style="padding: 10px; border: 1px solid #ccc; border-radius: 4px; width: 250px;">
                        </div>
                        <% } %>

                        <button type="submit" class="action-btn" style="padding: 15px 30px; font-size: 1.1rem; border:none; cursor:pointer;">Start Exam</button>
                    </form>
                    
                    <br>
                    <a href="student_exams.jsp" style="color: grey;">Cancel</a>
            </div> <!-- Close card -->
        </div> <!-- Close content-area -->
        </div> <!-- Close content-area -->
        
        <!-- Breakout Footer Wrapper -->
        <div style="width: 100vw; position: relative; left: 50%; right: 50%; margin-left: -50vw; margin-right: -50vw;">
            <%@ include file="footer.jsp" %>
        </div>
    </div> <!-- Close main-content -->
</body>
</html>
