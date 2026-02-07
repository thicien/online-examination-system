package com.oes.model;

public class Exam {
    private int id;
    private String name;
    private int duration;
    private int totalMarks;

    private String startTime;
    private String endTime;

    public Exam() {}

    public Exam(int id, String name, int duration, int totalMarks, String startTime, String endTime) {
        this.id = id;
        this.name = name;
        this.duration = duration;
        this.totalMarks = totalMarks;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }
    public int getTotalMarks() { return totalMarks; }
    public void setTotalMarks(int totalMarks) { this.totalMarks = totalMarks; }
    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }
    public String getEndTime() { return endTime; }
    public void setEndTime(String endTime) { this.endTime = endTime; }
}
