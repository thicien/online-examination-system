package com.oes.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ManualDbFix {
    // Copy credentials from DbConnection.java locally to be standalone
    private static final String URL = "jdbc:mysql://localhost:3306/online_exam_db";
    private static final String USER = "root"; 
    private static final String PASSWORD = ""; 

    public static void main(String[] args) {
        System.out.println("--- Starting Manual Database Fix ---");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("ERROR: MySQL Driver not found!");
            e.printStackTrace();
            return;
        }

        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            System.out.println("Connected to database successfully.");

            // 1. Check if 'password' column exists in 'exams' table
            boolean hasPassword = false;
            try (Statement st = con.createStatement();
                 ResultSet rs = st.executeQuery("DESCRIBE exams")) {
                while (rs.next()) {
                    String field = rs.getString("Field");
                    if ("password".equalsIgnoreCase(field)) {
                        hasPassword = true;
                        System.out.println("Field found: " + field);
                    }
                }
            }

            // 2. Add column if missing
            if (!hasPassword) {
                System.out.println("Password column is MISSING. Attempting to add it...");
                try (Statement st = con.createStatement()) {
                    st.executeUpdate("ALTER TABLE exams ADD COLUMN password VARCHAR(255) DEFAULT NULL");
                    System.out.println("SUCCESS: Added 'password' column to 'exams' table.");
                }
            } else {
                System.out.println("SUCCESS: 'password' column already exists.");
            }
            
            // 3. Optional: Verify with a test insert to ensure no other constraints fail
            // We won't commit this insert, just prepare it to check validity
            String testSql = "INSERT INTO exams (exam_name, duration, total_marks, start_time, end_time, password) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(testSql)) {
                 ps.setString(1, "Schema Test Exam");
                 ps.setInt(2, 10);
                 ps.setInt(3, 10);
                 ps.setString(4, "2030-01-01 10:00");
                 ps.setString(5, "2030-01-01 11:00");
                 ps.setString(6, "pass123");
                 // We don't execute update to avoid junk data, or we execute and delete.
                 // Let's execute and delete to be 100% sure.
                 int rows = ps.executeUpdate();
                 if (rows > 0) {
                     System.out.println("SUCCESS: Test INSERT worked.");
                     // Delete it
                     try (Statement st = con.createStatement()) {
                         st.executeUpdate("DELETE FROM exams WHERE exam_name='Schema Test Exam'");
                         System.out.println("Cleaned up test data.");
                     }
                 }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            // 4. List all exams to see what is actually there
            System.out.println("\n--- Current Exams in DB ---");
            try (Statement st = con.createStatement();
                 ResultSet rs = st.executeQuery("SELECT * FROM exams")) {
                boolean found = false;
                while (rs.next()) {
                    found = true;
                    int id = rs.getInt("exam_id");
                    String name = rs.getString("exam_name");
                    String pass = rs.getString("password");
                    System.out.println("ID: " + id + " | Name: " + name + " | Password: " + pass);
                }
                if (!found) System.out.println("No exams found in database.");
            }

        } catch (SQLException e) {
            System.err.println("Database Connection ERROR: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("--- Fix Complete ---");
    }
}
