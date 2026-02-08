package com.oes.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UpdateQuestionsSchema {
    // Database credentials
    private static final String URL = "jdbc:mysql://localhost:3306/online_exam_db";
    private static final String USER = "root"; 
    private static final String PASSWORD = ""; 

    public static void main(String[] args) {
        System.out.println("--- Starting Questions Schema Update ---");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("ERROR: MySQL Driver not found!");
            e.printStackTrace();
            return;
        }

        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            System.out.println("Connected to database successfully.");

            // Check if 'marks' column exists
            boolean hasMarks = false;
            try (Statement st = con.createStatement();
                 ResultSet rs = st.executeQuery("DESCRIBE questions")) {
                while (rs.next()) {
                    String field = rs.getString("Field");
                    if ("marks".equalsIgnoreCase(field)) {
                        hasMarks = true;
                        System.out.println("Field found: " + field);
                    }
                }
            }

            if (!hasMarks) {
                System.out.println("Marks column is MISSING. Adding it...");
                try (Statement st = con.createStatement()) {
                    // Default marks to 1 for existing questions
                    st.executeUpdate("ALTER TABLE questions ADD COLUMN marks INT DEFAULT 1");
                    System.out.println("SUCCESS: Added 'marks' column to 'questions' table.");
                }
            } else {
                System.out.println("SUCCESS: 'marks' column already exists.");
            }

        } catch (SQLException e) {
            System.err.println("Database Connection ERROR: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("--- Update Complete ---");
    }
}
