<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="sidebar">
    <div class="sidebar-brand">OES Student</div>
    <ul class="sidebar-menu">
        <li><a href="student_dashboard.jsp" class="<%= request.getRequestURI().contains("student_dashboard.jsp") ? "active" : "" %>">Dashboard</a></li>
        <li><a href="student_exams.jsp" class="<%= request.getRequestURI().contains("student_exams.jsp") ? "active" : "" %>">Available Exams</a></li>
        <li><a href="student_my_exams.jsp" class="<%= request.getRequestURI().contains("student_my_exams.jsp") ? "active" : "" %>">My Exams</a></li>
        <li><a href="student_profile.jsp" class="<%= request.getRequestURI().contains("student_profile.jsp") ? "active" : "" %>">Profile</a></li>
        <li><a href="auth?action=logout">Logout</a></li>
    </ul>
</div>
