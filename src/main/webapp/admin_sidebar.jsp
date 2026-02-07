<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="sidebar">
    <div class="sidebar-brand">OES Admin</div>
    <ul class="sidebar-menu">
        <li><a href="admin_dashboard.jsp" class="<%= request.getRequestURI().contains("admin_dashboard.jsp") ? "active" : "" %>">Dashboard</a></li>
        <li><a href="admin_users.jsp" class="<%= request.getRequestURI().contains("admin_users.jsp") ? "active" : "" %>">Manage Users</a></li>
        <li><a href="admin_exams.jsp" class="<%= request.getRequestURI().contains("admin_exams.jsp") ? "active" : "" %>">Manage Exams</a></li>
        <li><a href="admin_questions.jsp" class="<%= request.getRequestURI().contains("admin_questions.jsp") ? "active" : "" %>">Manage Questions</a></li>
        <li><a href="admin_results.jsp" class="<%= request.getRequestURI().contains("admin_results.jsp") ? "active" : "" %>">Results</a></li>
        <li><a href="auth?action=logout">Logout</a></li>
    </ul>
</div>
