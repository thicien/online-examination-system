<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.util.DbConnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Database Schema</title>
    <style>body { font-family: sans-serif; padding: 20px; line-height: 1.6; }</style>
</head>
<body>
    <h2>Database Schema Update</h2>
    <%
        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement()) {
            
            // 1. Check if columns exist (simple 'try-add' approach or check metadata)
            // We'll try to add them. If they exist, it might throw an error, so we catch it.
            
            boolean startTimeAdded = false;
            boolean endTimeAdded = false;

            try {
                st.executeUpdate("ALTER TABLE exams ADD COLUMN start_time DATETIME DEFAULT NULL");
                out.println("<p style='color:green'>&#10004; Added column 'start_time'</p>");
                startTimeAdded = true;
            } catch (SQLException e) {
                 if (e.getMessage().contains("Duplicate column")) {
                    out.println("<p style='color:orange'>&#9888; Column 'start_time' already exists.</p>");
                 } else {
                    out.println("<p style='color:red'>&#10060; Error adding 'start_time': " + e.getMessage() + "</p>");
                 }
            }

            try {
                st.executeUpdate("ALTER TABLE exams ADD COLUMN end_time DATETIME DEFAULT NULL");
                out.println("<p style='color:green'>&#10004; Added column 'end_time'</p>");
                endTimeAdded = true;
            } catch (SQLException e) {
                if (e.getMessage().contains("Duplicate column")) {
                    out.println("<p style='color:orange'>&#9888; Column 'end_time' already exists.</p>");
                 } else {
                    out.println("<p style='color:red'>&#10060; Error adding 'end_time': " + e.getMessage() + "</p>");
                 }
            }

        } catch (Exception e) {
            out.println("<p style='color:red'>Critical Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    %>
    <p>Done. You can delete this file now.</p>
    <a href="admin_dashboard.jsp">Go to Dashboard</a>
</body>
</html>
