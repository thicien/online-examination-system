package com.oes.dao;

import com.oes.model.StudentAnswer;
import com.oes.util.DbConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentAnswerDao {

    public boolean saveAnswer(StudentAnswer answer) {
        String query = "INSERT INTO student_answers (user_id, exam_id, question_id, selected_option, is_correct, marks_obtained) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, answer.getUserId());
            ps.setInt(2, answer.getExamId());
            ps.setInt(3, answer.getQuestionId());
            ps.setString(4, answer.getSelectedOption());
            ps.setBoolean(5, answer.isCorrect());
            ps.setInt(6, answer.getMarksObtained());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<StudentAnswer> getAnswersByExamAndUser(int examId, int userId) {
        List<StudentAnswer> list = new ArrayList<>();
        String query = "SELECT * FROM student_answers WHERE exam_id=? AND user_id=?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, examId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                StudentAnswer answer = new StudentAnswer();
                answer.setId(rs.getInt("answer_id"));
                answer.setUserId(rs.getInt("user_id"));
                answer.setExamId(rs.getInt("exam_id"));
                answer.setQuestionId(rs.getInt("question_id"));
                answer.setSelectedOption(rs.getString("selected_option"));
                answer.setCorrect(rs.getBoolean("is_correct"));
                answer.setMarksObtained(rs.getInt("marks_obtained"));
                list.add(answer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
