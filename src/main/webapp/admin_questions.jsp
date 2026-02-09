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
    <title>Manage Questions - OES</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
</head>
<body>
    <%@ include file="admin_sidebar.jsp" %>
    <div class="main-content">
        <%@ include file="admin_header.jsp" %>
        <div class="content-area">
            <h2 class="page-title">Manage Questions</h2>
            <p>Select an exam to manage its questions.</p>

            <div class="stats-grid">
                <% for (Exam e : exams) { %>
                <div class="stat-card" style="align-items: flex-start;">
                    <h3 style="font-size: 1.5rem;"><%= e.getName() %></h3>
                    <p>Total Marks: <%= e.getTotalMarks() %></p>
                    <div style="margin-top: 15px;">
                        <a href="add_question.jsp?examId=<%= e.getId() %>" class="btn-sm btn-view">Manage Questions</a>
                    </div>
                </div>
                <% } %>
            </div> <!-- Close table-container/list -->
        </div> <!-- Close content-area -->
        <%@ include file="footer.jsp" %>
    </div> <!-- Close main-content -->
</body>
</html>
