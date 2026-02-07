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

    // Time Validation
    java.time.LocalDateTime now = java.time.LocalDateTime.now();
    java.time.LocalDateTime start = null;
    java.time.LocalDateTime end = null;
    
    if (exam.getStartTime() != null && !exam.getStartTime().isEmpty()) {
        try { start = java.time.LocalDateTime.parse(exam.getStartTime().replace(" ", "T")); } catch(Exception e) {}
    }
    if (exam.getEndTime() != null && !exam.getEndTime().isEmpty()) {
        try { end = java.time.LocalDateTime.parse(exam.getEndTime().replace(" ", "T")); } catch(Exception e) {}
    }

    // 1. Check if too early
    if (start != null && now.isBefore(start)) {
        %>
        <script>
            alert("Exam has not started yet.");
            window.location.href = "student_dashboard.jsp";
        </script>
        <%
        return;
    }

    // 2. Check if expired
    if (end != null && now.isAfter(end)) {
        %>
        <script>
            alert("Exam has ended.");
            window.location.href = "student_dashboard.jsp";
        </script>
        <%
        return;
    }

    // 3. Calculate remaining seconds
    long remainingSeconds = exam.getDuration() * 60; // Default to duration
    if (end != null) {
        long secondsUntilEnd = java.time.temporal.ChronoUnit.SECONDS.between(now, end);
        if (secondsUntilEnd < remainingSeconds) {
            remainingSeconds = secondsUntilEnd;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Take Exam - <%= exam.getName() %></title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
    <style>
        .question-slide {
            display: none;
        }
        .question-slide.active {
            display: block;
        }
        .nav-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .option-label {
            display: block;
            margin-bottom: 10px;
            cursor: pointer;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .option-label:hover {
            background-color: #f8f9fa;
        }
        input[type="radio"] {
            margin-right: 10px;
        }
    </style>
    <script>
        var currentQuestion = 1;
        var totalQuestions = <%= questions.size() %>;

        function showQuestion(n) {
            // Hide all
            var slides = document.getElementsByClassName("question-slide");
            for (var i = 0; i < slides.length; i++) {
                slides[i].className = slides[i].className.replace(" active", "");
            }
            // Show current
            document.getElementById("question-" + n).className += " active";
            
            // Update buttons
            document.getElementById("btn-prev").style.display = (n == 1) ? "none" : "block";
            document.getElementById("btn-next").style.display = (n == totalQuestions) ? "none" : "block";
            document.getElementById("btn-submit").style.display = (n == totalQuestions) ? "block" : "none";
            
            // Update progress text
            document.getElementById("progress-text").innerText = "Question " + n + " of " + totalQuestions;
        }

        function nextQuestion() {
            if (currentQuestion < totalQuestions) {
                currentQuestion++;
                showQuestion(currentQuestion);
            }
        }

        function prevQuestion() {
            if (currentQuestion > 1) {
                currentQuestion--;
                showQuestion(currentQuestion);
            }
        }

        // Timer Logic
        var time = <%= remainingSeconds %>; 
        
        var timerInterval = setInterval(function() {
            if (time <= 0) {
                clearInterval(timerInterval);
                alert("Time is up!");
                document.getElementById("examForm").submit();
                return;
            }

            var hours = Math.floor(time / 3600);
            var minutes = Math.floor((time % 3600) / 60);
            var seconds = time % 60;
            
            // Format with leading zeros
            var display = "";
            if (hours > 0) display += hours + "h ";
            display += minutes + "m " + seconds + "s ";
            
            document.getElementById("timer").innerHTML = display;
            
            // Optional: visual warning at 1 min
            if(time < 60) {
                 document.getElementById("timer").style.color = "red";
            }
            
            time--;
        }, 1000);

        // Init
        window.onload = function() {
            showQuestion(1);
        };
    </script>
</head>
<body>
    
    <!-- Simplified Header -->
    <div class="top-navbar" style="position: sticky; top: 0; z-index: 1000;">
        <div class="page-name">
            <h3><%= exam.getName() %></h3>
        </div>
        <div style="display: flex; gap: 20px; align-items: center;">
            <div id="progress-text" style="font-weight: bold;">Question 1 of <%= questions.size() %></div>
            <div id="timer" style="font-weight: bold; font-size: 1.2rem; color: var(--primary-color);">Loading...</div>
        </div>
    </div>

    <div class="main-content" style="margin-left: 0; padding-top: 20px;"> <!-- No sidebar for exam focus -->
        <div class="content-area" style="max-width: 800px; margin: 0 auto;">
            
            <form id="examForm" action="exam" method="post">
                <input type="hidden" name="action" value="submit">
                <input type="hidden" name="examId" value="<%= exam.getId() %>">

                <% 
                int qIndex = 1; 
                for (Question q : questions) { 
                %>
                <div id="question-<%= qIndex %>" class="question-slide <%= (qIndex == 1) ? "active" : "" %>">
                    <div class="card">
                        <h3 style="margin-top: 0;">Q<%= qIndex %>: <%= q.getText() %></h3>
                        
                        <label class="option-label">
                            <input type="radio" name="q_<%= q.getId() %>" value="A"> <%= q.getOptionA() %>
                        </label>
                        <label class="option-label">
                            <input type="radio" name="q_<%= q.getId() %>" value="B"> <%= q.getOptionB() %>
                        </label>
                        <label class="option-label">
                            <input type="radio" name="q_<%= q.getId() %>" value="C"> <%= q.getOptionC() %>
                        </label>
                        <label class="option-label">
                            <input type="radio" name="q_<%= q.getId() %>" value="D"> <%= q.getOptionD() %>
                        </label>
                    </div>
                </div>
                <% 
                qIndex++; 
                } 
                %>

                <div class="nav-buttons">
                    <button type="button" id="btn-prev" class="action-btn" style="background-color: var(--secondary-color);" onclick="prevQuestion()">Previous</button>
                    <button type="button" id="btn-next" class="action-btn" onclick="nextQuestion()">Next</button>
                    <button type="submit" id="btn-submit" class="action-btn" style="background-color: var(--success-color); display: none;">Submit Exam</button>
                </div>
            </form>

        </div>
    </div>
</body>
</html>
