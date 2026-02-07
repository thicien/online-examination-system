<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.util.DbConnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head><title>DB Debug</title></head>
<body>
    <h2>Exams Table Columns</h2>
    <table border="1">
        <tr><th>Column Name</th><th>Type</th></tr>
        <%
            try (Connection con = DbConnection.getConnection();
                 Statement st = con.createStatement();
                 ResultSet rs = st.executeQuery("DESCRIBE exams")) {
                
                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getString("Field") %></td>
                <td><%= rs.getString("Type") %></td>
            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
                e.printStackTrace(new java.io.PrintWriter(out));
            }
        %>
    </table>
</body>
</html>
