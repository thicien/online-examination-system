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
    <title>Add Question - OES</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet">
</head>
<body>
    <%@ include file="admin_sidebar.jsp" %>
    <div class="main-content">
        <%@ include file="admin_header.jsp" %>
        <div class="content-area">
            <h2 class="page-title">Add Question</h2>
            
            <div class="table-container" style="max-width: 800px; margin: 0 auto;">
                <h3 style="margin-top:0;">Exam ID: <%= request.getParameter("examId") %></h3>
                
                <% if (request.getParameter("msg") != null) { %>
                    <p style="color: green; background: #e8f5e9; padding: 10px; border-radius: 4px;"><%= request.getParameter("msg") %></p>
                <% } %>

                <form action="admin" method="post">
                    <input type="hidden" name="action" value="addQuestion">
                    <input type="hidden" name="examId" value="<%= request.getParameter("examId") %>">
                    
                    <div style="margin-bottom: 15px;">
                        <label style="display:block; margin-bottom:5px; font-weight:600;">Question Text:</label>
                        <input type="text" name="questionText" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                    </div>
                    
                    <div style="display: flex; gap: 20px; margin-bottom: 15px;">
                        <div style="flex: 1;">
                            <label style="display:block; margin-bottom:5px;">Option A:</label>
                            <input type="text" name="optionA" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>
                        <div style="flex: 1;">
                            <label style="display:block; margin-bottom:5px;">Option B:</label>
                            <input type="text" name="optionB" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>
                    </div>
                    
                    <div style="display: flex; gap: 20px; margin-bottom: 15px;">
                        <div style="flex: 1;">
                            <label style="display:block; margin-bottom:5px;">Option C:</label>
                            <input type="text" name="optionC" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>
                        <div style="flex: 1;">
                            <label style="display:block; margin-bottom:5px;">Option D:</label>
                            <input type="text" name="optionD" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>
                    </div>
                    
                    <div style="margin-bottom: 20px;">
                        <label style="display:block; margin-bottom:5px; font-weight:600;">Correct Option:</label>
                        <select name="correctOption" style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                            <option value="A">Option A</option>
                            <option value="B">Option B</option>
                            <option value="C">Option C</option>
                            <option value="D">Option D</option>
                        </select>
                    </div>
                    
                    <button type="submit" class="action-btn" style="width: 100%; border: none; cursor: pointer;">Save Question</button>
                    <div style="text-align: center; margin-top: 10px;">
                        <a href="admin_exams.jsp" style="color: var(--secondary-color); text-decoration: none;">Back to Exams</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
