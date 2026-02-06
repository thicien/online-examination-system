package com.oes.dao;

import com.oes.model.Exam;
import com.oes.util.DbConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExamDao {

    public boolean addExam(Exam exam) {
        String query = "INSERT INTO exams (exam_name, duration, total_marks) VALUES (?, ?, ?)";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setString(1, exam.getName());
            ps.setInt(2, exam.getDuration());
            ps.setInt(3, exam.getTotalMarks());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Exam> getAllExams() {
        List<Exam> list = new ArrayList<>();
        String query = "SELECT * FROM exams ORDER BY exam_id DESC";
        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(query)) {
            
            while (rs.next()) {
                Exam exam = new Exam();
                exam.setId(rs.getInt("exam_id"));
                exam.setName(rs.getString("exam_name"));
                exam.setDuration(rs.getInt("duration"));
                exam.setTotalMarks(rs.getInt("total_marks"));
                list.add(exam);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Exam getExamById(int id) {
        Exam exam = null;
        String query = "SELECT * FROM exams WHERE exam_id=?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                exam = new Exam();
                exam.setId(rs.getInt("exam_id"));
                exam.setName(rs.getString("exam_name"));
                exam.setDuration(rs.getInt("duration"));
                exam.setTotalMarks(rs.getInt("total_marks"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exam;
    }
    
    public boolean deleteExam(int id) {
        String query = "DELETE FROM exams WHERE exam_id=?";
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
