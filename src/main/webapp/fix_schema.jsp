<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.util.DbConnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head><title>Fix Schema</title></head>
<body>
    <h2>Fixing Database Schema...</h2>
    <%
        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement()) {
            
            // Add start_time
            try {
                st.executeUpdate("ALTER TABLE exams ADD COLUMN start_time DATETIME DEFAULT NULL");
                out.println("<p style='color:green'>Added column: start_time</p>");
            } catch (SQLException e) {
                out.println("<p style='color:orange'>start_time: " + e.getMessage() + "</p>");
            }

            // Add end_time
            try {
                st.executeUpdate("ALTER TABLE exams ADD COLUMN end_time DATETIME DEFAULT NULL");
                out.println("<p style='color:green'>Added column: end_time</p>");
            } catch (SQLException e) {
                out.println("<p style='color:orange'>end_time: " + e.getMessage() + "</p>");
            }

        } catch (Exception e) {
            out.println("<p style='color:red'>Critical Error: " + e.getMessage() + "</p>");
            e.printStackTrace(new java.io.PrintWriter(out));
        }
    %>
    <p>Done. <a href="admin_dashboard.jsp">Go to Dashboard</a></p>
</body>
</html>
