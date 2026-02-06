<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.model.Exam" %>
<%@ page import="com.oes.model.Question" %>
<%@ page import="java.util.List" %>
<%
    Exam exam = (Exam) request.getAttribute("exam");
    List<Question> questions = (List<Question>) request.getAttribute("questions");
    if (exam == null || questions == null) {
        response.sendRedirect("student_dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Take Exam - <%= exam.getName() %></title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script>
        // Simple Timer
        var time = <%= exam.getDuration() %> * 60; // seconds
        setInterval(function() {
            var minutes = Math.floor(time / 60);
            var seconds = time % 60;
            document.getElementById("timer").innerHTML = minutes + "m " + seconds + "s ";
            time--;
            if (time < 0) {
                alert("Time is up!");
                document.getElementById("examForm").submit();
            }
        }, 1000);
    </script>
</head>
<body>
    <div class="navbar">
        <div class="logo">Taking Exam: <%= exam.getName() %></div>
        <div id="timer" style="font-weight: bold; font-size: 20px;"></div>
    </div>

    <div class="container">
        <form id="examForm" action="exam" method="post">
            <input type="hidden" name="action" value="submit">
            <input type="hidden" name="examId" value="<%= exam.getId() %>">

            <% int i = 1; for (Question q : questions) { %>
            <div class="card">
                <h3>Q<%= i++ %>: <%= q.getText() %></h3>
                
                <input type="radio" name="q_<%= q.getId() %>" value="A"> <%= q.getOptionA() %><br>
                <input type="radio" name="q_<%= q.getId() %>" value="B"> <%= q.getOptionB() %><br>
                <input type="radio" name="q_<%= q.getId() %>" value="C"> <%= q.getOptionC() %><br>
                <input type="radio" name="q_<%= q.getId() %>" value="D"> <%= q.getOptionD() %><br>
            </div>
            <% } %>

            <button type="submit" style="width: 200px; display: block; margin: 20px auto;">Submit Exam</button>
        </form>
    </div>
</body>
</html>
