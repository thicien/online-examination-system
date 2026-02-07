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
    <title>Manage Exams - OES</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
</head>
<body>
    <%@ include file="admin_sidebar.jsp" %>
    <div class="main-content">
        <%@ include file="admin_header.jsp" %>
        <div class="content-area">
            <h2 class="page-title">Manage Exams</h2>
            
            <div style="margin-bottom: 20px;">
                <a href="create_exam.jsp" class="action-btn">+ Create New Exam</a>
            </div>

            <% if (request.getParameter("msg") != null) { %>
                <p style="color: green; background: #e8f5e9; padding: 10px; border-radius: 4px;"><%= request.getParameter("msg") %></p>
            <% } %>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Exam Name</th>
                            <th>Duration (mins)</th>
                            <th>Total Marks</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Exam e : exams) { %>
                        <tr>
                            <td><%= e.getName() %></td>
                            <td><%= e.getDuration() %></td>
                            <td><%= e.getTotalMarks() %></td>
                            <td>
                                <a href="add_question.jsp?examId=<%= e.getId() %>" class="btn-sm btn-view">Add Questions</a>
                                <!-- Edit would go here -->
                                <a href="admin?action=deleteExam&id=<%= e.getId() %>" class="btn-sm btn-delete" onclick="return confirm('Are you sure you want to delete this exam? This action cannot be undone.')">Delete</a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
