<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.util.DbConnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head><title>Fix Password Schema</title></head>
<body>
    <h2>Adding Password Column...</h2>
    <%
        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement()) {
            
            try {
                st.executeUpdate("ALTER TABLE exams ADD COLUMN password VARCHAR(255) DEFAULT NULL");
                out.println("<p style='color:green'>Added column: password</p>");
            } catch (SQLException e) {
                out.println("<p style='color:orange'>password: " + e.getMessage() + "</p>");
            }

        } catch (Exception e) {
            out.println("<p style='color:red'>Critical Error: " + e.getMessage() + "</p>");
            e.printStackTrace(new java.io.PrintWriter(out));
        }
    %>
    <p>Done. <a href="admin_dashboard.jsp">Go to Dashboard</a></p>
</body>
</html>
