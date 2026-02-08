<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.dao.QuestionDao" %>
<%@ page import="com.oes.model.Question" %>
<%
    String idStr = request.getParameter("id");
    if (idStr == null) {
        response.sendRedirect("admin_dashboard.jsp");
        return;
    }
    int id = Integer.parseInt(idStr);
    QuestionDao dao = new QuestionDao();
    Question q = dao.getQuestionById(id);
    if (q == null) {
        response.sendRedirect("admin_dashboard.jsp?err=QuestionNotFound");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Question - OES</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
</head>
<body>
    <%@ include file="admin_sidebar.jsp" %>
    <div class="main-content">
        <%@ include file="admin_header.jsp" %>
        <div class="content-area">
            <h2 class="page-title">Edit Question</h2>
            
            <div class="table-container" style="max-width: 800px; margin: 0 auto;">
                <form action="admin" method="post">
                    <input type="hidden" name="action" value="updateQuestion">
                    <input type="hidden" name="questionId" value="<%= q.getId() %>">
                    <input type="hidden" name="examId" value="<%= q.getExamId() %>">
                    
                    <div style="margin-bottom: 15px;">
                        <label style="display:block; margin-bottom:5px; font-weight:600;">Question Text:</label>
                        <textarea name="questionText" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; min-height: 80px;"><%= q.getText() %></textarea>
                    </div>
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                        <div>
                            <label style="display:block; margin-bottom:5px; font-weight:600;">Option A:</label>
                            <input type="text" name="optionA" value="<%= q.getOptionA() %>" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>
                        <div>
                            <label style="display:block; margin-bottom:5px; font-weight:600;">Option B:</label>
                            <input type="text" name="optionB" value="<%= q.getOptionB() %>" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>
                        <div>
                            <label style="display:block; margin-bottom:5px; font-weight:600;">Option C:</label>
                            <input type="text" name="optionC" value="<%= q.getOptionC() %>" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>
                        <div>
                            <label style="display:block; margin-bottom:5px; font-weight:600;">Option D:</label>
                            <input type="text" name="optionD" value="<%= q.getOptionD() %>" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>
                    </div>
                    
                    <div style="margin-top: 15px; display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                        <div>
                            <label style="display:block; margin-bottom:5px; font-weight:600;">Correct Option:</label>
                            <select name="correctOption" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                                <option value="A" <%= "A".equals(q.getCorrectOption()) ? "selected" : "" %>>Option A</option>
                                <option value="B" <%= "B".equals(q.getCorrectOption()) ? "selected" : "" %>>Option B</option>
                                <option value="C" <%= "C".equals(q.getCorrectOption()) ? "selected" : "" %>>Option C</option>
                                <option value="D" <%= "D".equals(q.getCorrectOption()) ? "selected" : "" %>>Option D</option>
                            </select>
                        </div>
                        <div>
                            <label style="display:block; margin-bottom:5px; font-weight:600;">Marks:</label>
                            <input type="number" name="marks" value="<%= q.getMarks() %>" min="1" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>
                    </div>

                    <div style="margin-top: 20px; text-align: right;">
                        <a href="admin_questions.jsp?examId=<%= q.getExamId() %>" style="color: #6c757d; text-decoration: none; margin-right: 15px;">Cancel</a>
                        <button type="submit" class="action-btn" style="border: none; cursor: pointer;">Update Question</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
