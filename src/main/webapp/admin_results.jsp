<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.dao.ResultDao" %>
<%@ page import="com.oes.model.Result" %>
<%@ page import="com.oes.model.Admin" %>
<%@ page import="java.util.List" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    ResultDao resultDao = new ResultDao();
    List<Result> results = resultDao.getAllResults();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Results - OES</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
</head>
<body>
    <%@ include file="admin_sidebar.jsp" %>
    <div class="main-content">
        <%@ include file="admin_header.jsp" %>
        <div class="content-area">
            <h2 class="page-title">All Exam Results</h2>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Student</th>
                            <th>Exam</th>
                            <th>Score</th>
                            <th>Date</th>
                            <th>Result</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Result r : results) { 
                             boolean isPass = r.getScore() >= 40;
                        %>
                        <tr>
                            <td><%= r.getExamName().split(" - ")[0] %></td>
                            <td><%= r.getExamName().split(" - ")[1] %></td>
                            <td><%= r.getScore() %></td>
                            <td><%= r.getExamDate() %></td>
                            <td><span class="<%= isPass ? "status-pass" : "status-fail" %>"><%= isPass ? "Pass" : "Fail" %></span></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
