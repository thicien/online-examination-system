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
    </style>
</head>
<body>
    <%@ include file="student_sidebar.jsp" %>
    <div class="main-content">
        <%@ include file="student_header.jsp" %>
        <div class="content-area">
            <div style="display:flex; justify-content:space-between; align-items:center;">
                <h2 class="page-title">Review: <%= exam.getName() %></h2>
                <div style="font-size: 1.2rem; font-weight: bold;">
                    Score: <%= totalScore %> / <%= exam.getTotalMarks() %>
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
                            <span class="badge badge-success">+<%= q.getMarks() %> Marks</span>
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
                        <% if(isThisSelected) { %> (Your Answer) <% } %>
                        <% if(isThisCorrect) { %> (Correct) <% } %>
                    </div>
                    <% } %>
                </div>
            </div>
            <% } %>

            <div style="text-align: center; margin-top: 20px;">
                <a href="student_dashboard.jsp" class="btn-sm btn-view">Back to Dashboard</a>
            </div>
            </div>
        </div>
        <%@ include file="footer.jsp" %>
    </div>
</body>
</html>
