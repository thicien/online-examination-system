<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.dao.UserDao" %>
<%@ page import="com.oes.model.User" %>
<%@ page import="com.oes.model.Admin" %>
<%@ page import="java.util.List" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    UserDao userDao = new UserDao();
    List<User> users = userDao.getAllUsers();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users - OES</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
</head>
<body>
    <%@ include file="admin_sidebar.jsp" %>
    <div class="main-content">
        <%@ include file="admin_header.jsp" %>
        <div class="content-area">
            <h2 class="page-title">Manage Users</h2>

            <% if (request.getParameter("msg") != null) { %>
                <p style="color: green;"><%= request.getParameter("msg") %></p>
            <% } %>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (User u : users) { %>
                        <tr>
                            <td><%= u.getId() %></td>
                            <td><%= u.getName() %></td>
                            <td><%= u.getEmail() %></td>
                            <td>
                                <a href="admin?action=deleteUser&id=<%= u.getId() %>" class="btn-sm btn-delete" onclick="return confirm('Are you sure you want to delete this user? All their results will be lost.')">Delete</a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <%@ include file="footer.jsp" %>
    </div>
</body>
</html>
