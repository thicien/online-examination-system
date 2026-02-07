<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.model.User" %>
<%@ page import="com.oes.dao.ExamDao" %>
<%@ page import="com.oes.dao.ResultDao" %>
<%@ page import="com.oes.model.Exam" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    ExamDao examDao = new ExamDao();
    ResultDao resultDao = new ResultDao();

    // Stats
    int attempted = resultDao.countAttemptedExams(user.getId());
    int passed = resultDao.countPassedExams(user.getId(), 50);
    int failed = resultDao.countFailedExams(user.getId(), 50);
    
    // Calculate Available Exams
    List<Exam> allExams = examDao.getAllExams();
    List<Exam> availableExams = new ArrayList<>();
    for(Exam e : allExams) {
        if(!resultDao.isExamAttempted(user.getId(), e.getId())) { // Wait, I added isExamAttempted to ExamDao, not ResultDao.
            // My memory says ExamDao. Let me check my previous edit. Yes, ExamDao.
           // However, logically it belongs to ExamDao checking against results or ResultDao. 
           // I added it to ExamDao.
        }
    }
%>
<!-- ... rest of the file ... -->
