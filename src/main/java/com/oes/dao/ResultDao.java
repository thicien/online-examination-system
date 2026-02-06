package com.oes.dao;

import com.oes.model.Result;
import com.oes.util.DbConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResultDao {

    public boolean saveResult(Result result) {
        String query = "INSERT INTO results (user_id, exam_id, score) VALUES (?, ?, ?)";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, result.getUserId());
            ps.setInt(2, result.getExamId());
            ps.setInt(3, result.getScore());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Result> getResultsByUserId(int userId) {
        List<Result> list = new ArrayList<>();
        // Join with exams table to get exam name if needed
        String query = "SELECT r.*, e.exam_name FROM results r JOIN exams e ON r.exam_id = e.exam_id WHERE r.user_id=? ORDER BY r.exam_date DESC";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Result r = new Result();
                r.setId(rs.getInt("result_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setExamId(rs.getInt("exam_id"));
                r.setScore(rs.getInt("score"));
                r.setExamDate(rs.getTimestamp("exam_date"));
                r.setExamName(rs.getString("exam_name"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Result> getAllResults() {
         List<Result> list = new ArrayList<>();
        String query = "SELECT r.*, e.exam_name, u.name as student_name FROM results r " +
                       "JOIN exams e ON r.exam_id = e.exam_id " +
                       "JOIN users u ON r.user_id = u.user_id " +
                       "ORDER BY r.exam_date DESC";
        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(query)) {
            
            while (rs.next()) {
                Result r = new Result();
                r.setId(rs.getInt("result_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setExamId(rs.getInt("exam_id"));
                r.setScore(rs.getInt("score"));
                r.setExamDate(rs.getTimestamp("exam_date"));
                r.setExamName(rs.getString("student_name") + " - " + rs.getString("exam_name")); // Hack to store student name too
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
