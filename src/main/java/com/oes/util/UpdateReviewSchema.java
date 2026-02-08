package com.oes.util;

import java.sql.Connection;
import java.sql.Statement;

public class UpdateReviewSchema {
    public static void main(String[] args) {
        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement()) {
            
            // Create student_answers table
            String sql = "CREATE TABLE IF NOT EXISTS student_answers (" +
                         "answer_id INT AUTO_INCREMENT PRIMARY KEY, " +
                         "user_id INT, " +
                         "exam_id INT, " +
                         "question_id INT, " +
                         "selected_option VARCHAR(1), " +
                         "is_correct BOOLEAN, " +
                         "marks_obtained INT, " +
                         "FOREIGN KEY (user_id) REFERENCES users(user_id), " +
                         "FOREIGN KEY (exam_id) REFERENCES exams(exam_id), " +
                         "FOREIGN KEY (question_id) REFERENCES questions(question_id)" +
                         ")";
            st.executeUpdate(sql);
            System.out.println("Schema updated: student_answers table created successfully.");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
