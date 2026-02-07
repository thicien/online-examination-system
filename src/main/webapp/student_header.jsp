<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    String userName = (currentUser != null) ? currentUser.getName() : "Student";
%>
<div class="top-navbar">
    <div class="page-name">
        <h3>Online Examination System</h3>
    </div>
    <div class="user-info">
        <span>Welcome, <strong><%= userName %></strong></span>
        <a href="auth?action=logout" class="logout-btn">Logout</a>
    </div>
</div>
