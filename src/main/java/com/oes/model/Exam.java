package com.oes.model;

public class Exam {
    private int id;
    private String name;
    private int duration;
    private int totalMarks;

    public Exam() {}

    public Exam(int id, String name, int duration, int totalMarks) {
        this.id = id;
        this.name = name;
        this.duration = duration;
        this.totalMarks = totalMarks;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }
    public int getTotalMarks() { return totalMarks; }
    public void setTotalMarks(int totalMarks) { this.totalMarks = totalMarks; }
}
