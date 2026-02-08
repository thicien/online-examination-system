package com.oes.model;

public class StudentAnswer {
    private int id;
    private int userId;
    private int examId;
    private int questionId;
    private String selectedOption;
    private boolean isCorrect;
    private int marksObtained;

    public StudentAnswer() {}

    public StudentAnswer(int userId, int examId, int questionId, String selectedOption, boolean isCorrect, int marksObtained) {
        this.userId = userId;
        this.examId = examId;
        this.questionId = questionId;
        this.selectedOption = selectedOption;
        this.isCorrect = isCorrect;
        this.marksObtained = marksObtained;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getExamId() { return examId; }
    public void setExamId(int examId) { this.examId = examId; }

    public int getQuestionId() { return questionId; }
    public void setQuestionId(int questionId) { this.questionId = questionId; }

    public String getSelectedOption() { return selectedOption; }
    public void setSelectedOption(String selectedOption) { this.selectedOption = selectedOption; }

    public boolean isCorrect() { return isCorrect; }
    public void setCorrect(boolean isCorrect) { this.isCorrect = isCorrect; }

    public int getMarksObtained() { return marksObtained; }
    public void setMarksObtained(int marksObtained) { this.marksObtained = marksObtained; }
}
