package com.oes.dao;

import com.oes.model.Question;
import com.oes.util.DbConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuestionDao {

    public boolean addQuestion(Question q) {
        String query = "INSERT INTO questions (exam_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, q.getExamId());
            ps.setString(2, q.getText());
            ps.setString(3, q.getOptionA());
            ps.setString(4, q.getOptionB());
            ps.setString(5, q.getOptionC());
            ps.setString(6, q.getOptionD());
            ps.setString(7, q.getCorrectOption());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Question> getQuestionsByExamId(int examId) {
        List<Question> list = new ArrayList<>();
        String query = "SELECT * FROM questions WHERE exam_id=?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, examId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Question q = new Question();
                q.setId(rs.getInt("question_id"));
                q.setExamId(rs.getInt("exam_id"));
                q.setText(rs.getString("question_text"));
                q.setOptionA(rs.getString("option_a"));
                q.setOptionB(rs.getString("option_b"));
                q.setOptionC(rs.getString("option_c"));
                q.setOptionD(rs.getString("option_d"));
                q.setCorrectOption(rs.getString("correct_option"));
                list.add(q);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public boolean deleteQuestion(int id) {
        String query = "DELETE FROM questions WHERE question_id=?";
         try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
