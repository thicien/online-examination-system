<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile - OES</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
</head>
<body>

    <!-- Sidebar -->
    <%@ include file="student_sidebar.jsp" %>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <%@ include file="student_header.jsp" %>

        <!-- Content Area -->
        <div class="content-area">
            <h2 class="page-title">My Profile</h2>

            <div class="card" style="max-width: 600px; padding: 20px;">
                <h3 style="margin-top:0;">Personal Details</h3>
                <div style="margin-bottom: 20px;">
                    <label style="font-weight:bold; display:block;">Name:</label>
                    <span><%= user.getName() %></span>
                </div>
                <div style="margin-bottom: 20px;">
                    <label style="font-weight:bold; display:block;">Email:</label>
                    <span><%= user.getEmail() %></span>
                </div>
                
                <hr style="border: 0; border-top: 1px solid #eee; margin: 20px 0;">
                
                <h3>Change Password</h3>
                <form action="auth" method="post">
                    <input type="hidden" name="action" value="updatePassword">
                    <div style="margin-bottom: 15px;">
                        <label style="display:block; margin-bottom:5px;">New Password</label>
                        <input type="password" name="newPassword" required style="width: 100%; padding: 8px;">
                    </div>
                    <button type="submit" class="action-btn">Update Password</button>
                </form>
            </div> <!-- Close card -->
        </div> <!-- Close content-area -->
        <%@ include file="footer.jsp" %>
    </div> <!-- Close main-content -->
</body>
</html>
