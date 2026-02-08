<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.dao.ExamDao" %>
<%@ page import="com.oes.model.Exam" %>
<%
    String idStr = request.getParameter("id");
    if (idStr == null) {
        response.sendRedirect("admin_exams.jsp");
        return;
    }
    int id = Integer.parseInt(idStr);
    ExamDao dao = new ExamDao();
    Exam exam = dao.getExamById(id);
    if (exam == null) {
        response.sendRedirect("admin_exams.jsp?err=ExamNotFound");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Exam</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
</head>
<body>
    
    <!-- Sidebar -->
    <jsp:include page="admin_sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <jsp:include page="admin_header.jsp" />

        <div class="container">
            <div class="card" style="max-width: 600px; margin: 0 auto;">
                <div class="card-header">
                    <h2>Edit Exam</h2>
                </div>
                <form action="admin" method="post" style="padding: 20px;">
                    <input type="hidden" name="action" value="updateExam">
                    <input type="hidden" name="examId" value="<%= exam.getId() %>">
                    
                    <div class="form-group">
                        <label>Exam Name</label>
                        <input type="text" name="examName" value="<%= exam.getName() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Duration (minutes)</label>
                        <input type="number" name="duration" value="<%= exam.getDuration() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Total Marks</label>
                        <input type="number" name="totalMarks" value="<%= exam.getTotalMarks() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Start Time</label>
                        <input type="datetime-local" name="startTime" value="<%= exam.getStartTime() != null ? exam.getStartTime() : "" %>" required>
                    </div>
                    <div class="form-group">
                        <label>End Time</label>
                        <input type="datetime-local" name="endTime" value="<%= exam.getEndTime() != null ? exam.getEndTime() : "" %>" required>
                    </div>
                    <div class="form-group">
                        <label>Exam Password</label>
                        <input type="text" name="password" value="<%= exam.getPassword() != null ? exam.getPassword() : "" %>" placeholder="Leave empty for open access">
                    </div>
                    <button type="submit" class="btn">Update Exam</button>
                    <a href="admin_exams.jsp" class="btn" style="background-color: #6c757d; text-decoration: none; display: inline-block; text-align: center;">Cancel</a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
