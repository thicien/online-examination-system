<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.model.Admin" %>
<%@ page import="com.oes.dao.QuestionDao" %>
<%@ page import="com.oes.model.Question" %>
<%@ page import="java.util.List" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    String examIdStr = request.getParameter("examId");
    if (examIdStr == null) {
        response.sendRedirect("admin_dashboard.jsp");
        return;
    }
    int examId = Integer.parseInt(examIdStr);
    
    QuestionDao questionDao = new QuestionDao();
    List<Question> questions = questionDao.getQuestionsByExamId(examId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Questions - OES</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet">
</head>
<body>
    <%@ include file="admin_sidebar.jsp" %>
    <div class="main-content">
        <%@ include file="admin_header.jsp" %>
        <div class="content-area">
            <h2 class="page-title">Manage Questions (Exam ID: <%= examId %>)</h2>
            
            <!-- ADD QUESTION FORM -->
            <div class="table-container" style="max-width: 800px; margin: 0 auto; margin-bottom: 30px;">
                <h3>Add New Question</h3>
                <% if (request.getParameter("msg") != null) { %>
                    <p style="color: green; background: #e8f5e9; padding: 10px; border-radius: 4px;"><%= request.getParameter("msg") %></p>
                <% } %>

                <form action="admin" method="post">
                    <input type="hidden" name="action" value="addQuestion">
                    <input type="hidden" name="examId" value="<%= examId %>">
                    
                    <div style="margin-bottom: 15px;">
                        <label style="display:block; margin-bottom:5px; font-weight:600;">Question Text:</label>
                        <textarea name="questionText" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; min-height: 60px;"></textarea>
                    </div>
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                        <div>
                            <label style="display:block; margin-bottom:5px;">Option A:</label>
                            <input type="text" name="optionA" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>
                        <div>
                            <label style="display:block; margin-bottom:5px;">Option B:</label>
                            <input type="text" name="optionB" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>
                        <div>
                            <label style="display:block; margin-bottom:5px;">Option C:</label>
                            <input type="text" name="optionC" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>
                        <div>
                            <label style="display:block; margin-bottom:5px;">Option D:</label>
                            <input type="text" name="optionD" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>
                    </div>
                    
                    <div style="margin-top: 15px; display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                        <div>
                            <label style="display:block; margin-bottom:5px; font-weight:600;">Correct Option:</label>
                            <select name="correctOption" style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                                <option value="A">Option A</option>
                                <option value="B">Option B</option>
                                <option value="C">Option C</option>
                                <option value="D">Option D</option>
                            </select>
                        </div>
                        <div>
                            <label style="display:block; margin-bottom:5px; font-weight:600;">Marks:</label>
                            <input type="number" name="marks" value="1" min="1" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>
                    </div>
                    
                    <button type="submit" class="action-btn" style="width: 100%; border: none; cursor: pointer; margin-top: 20px;">Add Question</button>
                    <div style="text-align: center; margin-top: 10px;">
                        <a href="admin_exams.jsp" style="color: var(--secondary-color); text-decoration: none;">Back to Exams</a>
                    </div>
                </form>
            </div>

            <!-- EXISTING QUESTIONS LIST -->
            <div class="table-container">
                <h3>Existing Questions (<%= questions.size() %>)</h3>
                <table class="data-table" style="width:100%">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Question</th>
                            <th>Correct</th>
                            <th>Marks</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Question q : questions) { %>
                        <tr>
                            <td><%= q.getId() %></td>
                            <td><%= q.getText().length() > 50 ? q.getText().substring(0, 47) + "..." : q.getText() %></td>
                            <td><%= q.getCorrectOption() %></td>
                            <td><%= q.getMarks() %></td>
                            <td>
                                <a href="edit_question.jsp?id=<%= q.getId() %>" class="btn-sm btn-edit">Edit</a>
                                <!-- Delete could be efficiently implemented here too -->
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
