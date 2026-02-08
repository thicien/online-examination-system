<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.dao.ExamDao" %>
<%@ page import="com.oes.model.Exam" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head><title>Debug Exams List</title></head>
<body>
    <h2>Debug: All Exams in Database</h2>
    <table border="1" cellpadding="5">
        <tr>
            <th>ID</th><th>Name</th><th>Start Time</th><th>End Time</th><th>Password</th>
        </tr>
    <%
        ExamDao dao = new ExamDao();
        List<Exam> list = dao.getAllExams();
        for (Exam e : list) {
    %>
        <tr>
            <td><%= e.getId() %></td>
            <td><%= e.getName() %></td>
            <td><%= e.getStartTime() %></td>
            <td><%= e.getEndTime() %></td>
            <td><%= e.getPassword() %></td>
        </tr>
    <% } %>
    </table>
    <p>Total: <%= list.size() %></p>
</body>
</html>
