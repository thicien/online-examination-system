<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.dao.*" %>
<%@ page import="com.oes.model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String examIdStr = request.getParameter("examId");
    if (examIdStr == null) {
        response.sendRedirect("student_dashboard.jsp");
        return;
    }
    int examId = Integer.parseInt(examIdStr);

    ExamDao examDao = new ExamDao();
    QuestionDao questionDao = new QuestionDao();
    StudentAnswerDao answerDao = new StudentAnswerDao();

    Exam exam = examDao.getExamById(examId);
    List<Question> questions = questionDao.getQuestionsByExamId(examId);
    List<StudentAnswer> answers = answerDao.getAnswersByExamAndUser(examId, user.getId());

    // Map answers by questionId for easy lookup
    Map<Integer, StudentAnswer> answerMap = new HashMap<>();
    for (StudentAnswer a : answers) {
        answerMap.put(a.getQuestionId(), a);
    }
    
    int totalScore = 0;
    for (StudentAnswer a : answers) {
        totalScore += a.getMarksObtained();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Review Exam - <%= exam.getName() %></title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
    <style>
        .question-card {
            background: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-left: 5px solid #ddd;
        }
        /* ... existing styles ... */
        .question-card.correct { border-left-color: #2ecc71; }
        .question-card.wrong { border-left-color: #e74c3c; }
        .question-text { font-size: 1.1rem; font-weight: 600; margin-bottom: 15px; }
        .options-grid { display: grid; gap: 10px; }
        .option-item {
            padding: 10px;
            border: 1px solid #eee;
            border-radius: 4px;
        }
        .option-item.selected { background-color: #e8f4fd; border-color: #3498db; }
        .option-item.correct-answer { background-color: #d4edda; border-color: #28a745; color: #155724; font-weight: bold;}
        .option-item.wrong-selected { background-color: #f8d7da; border-color: #dc3545; color: #721c24; }
        
        .badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.85rem;
            color: #fff;
        }
        .badge-success { background-color: #2ecc71; }
        .badge-danger { background-color: #e74c3c; }
        .badge-neutral { background-color: #95a5a6; }

        /* Layout overrides for Focus Mode */
        body {
            display: block !important;
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
        .content-area {
            max-width: 1000px;
            margin: 0 auto;
            padding: 30px;
        }
    </style>
</head>
<body>
    <!-- Sidebar Removed for Focus Mode -->
    
    <div class="main-content">
        <%@ include file="student_header.jsp" %>
        <div class="content-area">
            <!-- Top Actions -->
            <div style="margin-bottom: 20px;">
                <a href="student_dashboard.jsp" class="btn-sm btn-view" style="display: inline-block; text-decoration: none; font-weight: bold;">&larr; Back to Dashboard</a>
            </div>

            <div style="display:flex; justify-content:space-between; align-items:center;">
                <h2 class="page-title">Review: <%= exam.getName() %></h2>
                <div style="font-size: 1.2rem; font-weight: bold;">
                    Total Score: <%= totalScore %> / <%= exam.getTotalMarks() %>
                </div>
            </div>

            <% if (answers.isEmpty()) { %>
                <div class="alert" style="background: #fff3cd; color: #856404; padding: 15px; border-radius: 4px;">
                    Review is not available for this exam attempt (it might be an old attempt before the review system was active).
                </div>
            <% } %>

            <% for (Question q : questions) { 
                StudentAnswer ans = answerMap.get(q.getId());
                boolean isAnswered = ans != null;
                boolean isCorrect = isAnswered && ans.isCorrect();
                String selected = isAnswered ? ans.getSelectedOption() : "";
                String styleClass = !isAnswered ? "" : (isCorrect ? "correct" : "wrong");
            %>
            <div class="question-card <%= styleClass %>">
                <div style="display:flex; justify-content:space-between;">
                    <div class="question-text"><%= q.getText() %></div>
                    <div>
                        <% if(isCorrect) { %>
                            <span class="badge badge-success"><%= q.getMarks() %> / <%= q.getMarks() %></span>
                        <% } else { %>
                             <span class="badge badge-danger">0 / <%= q.getMarks() %></span>
                        <% } %>
                    </div>
                </div>

                <div class="options-grid">
                    <% 
                        String[] opts = {"A", "B", "C", "D"};
                        String[] optTexts = {q.getOptionA(), q.getOptionB(), q.getOptionC(), q.getOptionD()};
                        for(int i=0; i<4; i++) {
                            String optLabel = opts[i];
                            String optText = optTexts[i];
                            String itemClass = "option-item";
                            
                            boolean isThisSelected = selected != null && selected.equals(optLabel);
                            boolean isThisCorrect = q.getCorrectOption().equals(optLabel);
                            
                            if (isThisCorrect) {
                                itemClass += " correct-answer";
                            } else if (isThisSelected) { // Selected but wrong (since we checked correct above)
                                itemClass += " wrong-selected"; 
                            }
                    %>
                    <div class="<%= itemClass %>">
                        <strong><%= optLabel %>:</strong> <%= optText %>
                        <% if(isThisSelected) { %> 
                            <span style="font-weight: bold; margin-left: 5px;">(Your Answer)</span> 
                        <% } %>
                        <% if(isThisCorrect) { %> 
                            <span style="font-weight: bold; margin-left: 5px;">(Correct Answer)</span> 
                        <% } %>
                    </div>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div> <!-- Close content-area -->
        
        <!-- Breakout Footer Wrapper -->
        <div style="width: 100vw; position: relative; left: 50%; right: 50%; margin-left: -50vw; margin-right: -50vw;">
            <%@ include file="footer.jsp" %>
        </div>
    </div>
</body>
</html>
