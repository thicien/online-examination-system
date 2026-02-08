package com.oes.dao;

import com.oes.model.Exam;
import com.oes.util.DbConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExamDao {

    // Add Exam
    public boolean addExam(Exam exam) {
        String query = "INSERT INTO exams (exam_name, duration, total_marks, start_time, end_time, password) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, exam.getName());
            ps.setInt(2, exam.getDuration());
            ps.setInt(3, exam.getTotalMarks());
            ps.setString(4, exam.getStartTime());
            ps.setString(5, exam.getEndTime());
            ps.setString(6, exam.getPassword());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update Exam
    public boolean updateExam(Exam exam) {
        String query = "UPDATE exams SET exam_name=?, duration=?, total_marks=?, start_time=?, end_time=?, password=? WHERE exam_id=?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, exam.getName());
            ps.setInt(2, exam.getDuration());
            ps.setInt(3, exam.getTotalMarks());
            ps.setString(4, exam.getStartTime());
            ps.setString(5, exam.getEndTime());
            ps.setString(6, exam.getPassword());
            ps.setInt(7, exam.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get All Exams
    public List<Exam> getAllExams() {
        List<Exam> list = new ArrayList<>();
        String query = "SELECT * FROM exams";
        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(query)) {
            
            while (rs.next()) {
                Exam exam = new Exam();
                exam.setId(rs.getInt("exam_id"));
                exam.setName(rs.getString("exam_name"));
                exam.setDuration(rs.getInt("duration"));
                exam.setTotalMarks(rs.getInt("total_marks"));
                exam.setPassword(rs.getString("password"));
                
                // Retrieve timestamps as Strings for simplicity, handling nulls
                Timestamp startTs = rs.getTimestamp("start_time");
                Timestamp endTs = rs.getTimestamp("end_time");
                if (startTs != null) exam.setStartTime(startTs.toString().substring(0, 16).replace(" ", "T")); // Format for datetime-local
                if (endTs != null) exam.setEndTime(endTs.toString().substring(0, 16).replace(" ", "T"));

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
                exam.setPassword(rs.getString("password"));
                
                Timestamp startTs = rs.getTimestamp("start_time");
                Timestamp endTs = rs.getTimestamp("end_time");
                if (startTs != null) exam.setStartTime(startTs.toString().substring(0, 16).replace(" ", "T")); // Format for datetime-local
                if (endTs != null) exam.setEndTime(endTs.toString().substring(0, 16).replace(" ", "T"));
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

    public int getExamCount() {
        int count = 0;
        String query = "SELECT COUNT(*) FROM exams";
        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(query)) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean isExamAttempted(int userId, int examId) {
        String query = "SELECT COUNT(*) FROM results WHERE user_id=? AND exam_id=?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, examId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
