package com.techelevator.model;

public class Course {

    private String title;
    private String description;
    private int difficultyLevel;
    private double cost;

    private int courseID;

    public Course(String title, String description, int difficultyLevel, double cost) {
        System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        this.title = title;
        this.description = description;
        this.difficultyLevel = difficultyLevel;
        this.cost = cost;
    }

    public Course() {
        super();
    }


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDifficultyLevel() {
        return difficultyLevel;
    }

    public void setDifficultyLevel(int difficultyLevel) {
        this.difficultyLevel = difficultyLevel;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public Course(String courseName, int courseID) {
        this.title = courseName;
        this.courseID = courseID;
    }



    public Course(String title, String description, int difficultyLevel, double cost, int courseID) {
        this.title = title;
        this.description = description;
        this.difficultyLevel = difficultyLevel;
        this.cost = cost;
        this.courseID = courseID;
    }


}
