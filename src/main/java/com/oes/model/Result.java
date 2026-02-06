package com.oes.model;

import java.sql.Timestamp;

public class Result {
    private int id;
    private int userId;
    private int examId;
    private int score;
    private Timestamp examDate;

    // Optional: for display purposes, store Exam Name here or join in DB query
    private String examName;

    public Result() {}

    public Result(int id, int userId, int examId, int score, Timestamp examDate) {
        this.id = id;
        this.userId = userId;
        this.examId = examId;
        this.score = score;
        this.examDate = examDate;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getExamId() { return examId; }
    public void setExamId(int examId) { this.examId = examId; }
    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }
    public Timestamp getExamDate() { return examDate; }
    public void setExamDate(Timestamp examDate) { this.examDate = examDate; }
    public String getExamName() { return examName; }
    public void setExamName(String examName) { this.examName = examName; }
}
