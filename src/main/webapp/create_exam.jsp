<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.model.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Exam - OES</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet">
</head>
<body>
    <%@ include file="admin_sidebar.jsp" %>
    <div class="main-content">
        <%@ include file="admin_header.jsp" %>
        <div class="content-area">
            <h2 class="page-title">Create New Exam</h2>
            
            <div class="table-container" style="max-width: 600px; margin: 0 auto;">
                <form action="admin" method="post">
                    <input type="hidden" name="action" value="addExam">
                    
                    <div style="margin-bottom: 15px;">
                        <label style="display:block; margin-bottom:5px; font-weight:600;">Exam Name:</label>
                        <input type="text" name="examName" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                    </div>
                    
                    <div style="margin-bottom: 15px;">
                        <label style="display:block; margin-bottom:5px; font-weight:600;">Duration (minutes):</label>
                        <input type="number" name="duration" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                    </div>
                    
                    <div style="margin-bottom: 15px;">
                        <label style="display:block; margin-bottom:5px; font-weight:600;">Total Marks:</label>
                        <input type="number" name="totalMarks" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                    </div>

                    <div style="margin-bottom: 15px;">
                        <label style="display:block; margin-bottom:5px; font-weight:600;">Start Time:</label>
                        <input type="datetime-local" name="startTime" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                    </div>

                    <div style="margin-bottom: 15px;">
                        <label style="display:block; margin-bottom:5px; font-weight:600;">End Time:</label>
                        <input type="datetime-local" name="endTime" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                    </div>

                    <div style="margin-bottom: 15px;">
                        <label style="display:block; margin-bottom:5px; font-weight:600;">Exam Password (Optional):</label>
                        <input type="text" name="password" placeholder="Leave empty for open access" style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                    </div>
                    
                    <button type="submit" class="action-btn" style="width: 100%; border: none; cursor: pointer;">Create Exam</button>
                    <div style="text-align: center; margin-top: 10px;">
                        <a href="admin_exams.jsp" style="color: var(--secondary-color); text-decoration: none;">Cancel</a>
                    </div>
                </form>
            </div> <!-- Close form card -->
        </div> <!-- Close content-area -->
        <%@ include file="footer.jsp" %>
    </div> <!-- Close main-content -->
</body>
</html>
