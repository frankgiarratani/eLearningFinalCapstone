package com.techelevator.model;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDate;

public class Assignment {

    // Fields
    private int studentID;
    private int courseID;
    private int assignmentID;
    private int assignmentNumber;
    private String assignmentName;
    private String description;
    private int possiblePoints;
    boolean isSubmitted = false;
    String submission;
    double studentGrade = 0;
    boolean isGraded = false;
    String teacherFeedback;
    @JsonFormat(pattern="yyyy-MM-dd")
    LocalDate submissionDateTime;
    @JsonFormat(pattern="yyyy-MM-dd")
    private LocalDate dueDate;

//     Constructors
    public Assignment() {
        super();
    }

    public Assignment(int courseID, int assignmentNumber, String assignmentName, String description, int possiblePoints,
                      LocalDate dueDate, String submission, double studentGrade, LocalDate submissionDateTime, boolean isSubmitted, boolean isGraded,
                      String teacherFeedback) {
        this.courseID = courseID;
        this.assignmentNumber = assignmentNumber;
        this.assignmentName = assignmentName;
        this.description = description;
        this.possiblePoints = possiblePoints;
        this.dueDate = dueDate;

        this.isSubmitted = isSubmitted;
        this.isGraded = isGraded;
        this.submission = submission;
        this.teacherFeedback = teacherFeedback;
        this.submissionDateTime = submissionDateTime;
        this.studentGrade = studentGrade;

    }

    // Methods


    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public boolean isSubmitted() {
        return isSubmitted;
    }

    public void setSubmitted() {
        this.isSubmitted = isSubmitted;
    }


    public void setSubmitted(boolean submitted) {
        isSubmitted = submitted;
    }

    public String getSubmission() {
        return submission;
    }

    public void setSubmission(String submission) {
        this.submission = submission;
    }

    public double getStudentGrade() {
        return studentGrade;
    }

    public void setStudentGrade(double studentGrade) {
        this.studentGrade = studentGrade;
    }


    public String getTeacherFeedback() {
        return teacherFeedback;
    }

    public void setTeacherFeedback(String teacherFeedback) {
        this.teacherFeedback = teacherFeedback;
    }

    public LocalDate getSubmittedDateTime() {
        return submissionDateTime;
    }

    public void setSubmittedDateTime(LocalDate submissionDateTime) {
        this.submissionDateTime = submissionDateTime;
    }

    public boolean isGraded() {
        return isGraded;
    }

    public void setGraded(boolean isGraded) {
        this.isGraded = isGraded;
    }



    // Getters & Setters
    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public int getAssignmentID() {
        return assignmentID;
    }

    public void setAssignmentID(int assignmentId) {
        this.assignmentID = assignmentId;
    }

    public int getAssignmentNumber() {
        return assignmentNumber;
    }

    public void setAssignmentNumber(int assignmentNumber) {
        this.assignmentNumber = assignmentNumber;
    }

    public String getAssignmentName() {
        return assignmentName;
    }

    public void setAssignmentName(String assignmentName) {
        this.assignmentName = assignmentName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPossiblePoints() {
        return possiblePoints;
    }

    public void setPossiblePoints(int possiblePoints) {
        this.possiblePoints = possiblePoints;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }
}
