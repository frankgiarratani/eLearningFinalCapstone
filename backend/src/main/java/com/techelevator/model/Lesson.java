package com.techelevator.model;

import java.util.Date;

public class Lesson {
    private int courseID;
    private int lessonID;
    private int lessonNumber;
    private String lessonName;
    private String description;
    private String youtubeURL;
    private String youtubeText;
    private String lessonURL1;
    private String lessonURL2;
private String videoId;

    public Lesson(int lessonNumber, String lessonName, String description) {
        this.lessonNumber = lessonNumber;
        this.lessonName = lessonName;
        this.description = description;
    }

    public Lesson(int lessonID, int lessonNumber, String lessonName, String description) {
        this.lessonID = lessonID;
        this.lessonNumber = lessonNumber;
        this.lessonName = lessonName;
        this.description = description;
    }


    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public Lesson() {
        super();
    }

    public Lesson(int courseID, int lessonID, int lessonNumber, String lessonName, String description, String youtubeURL, String youtubeText, String lessonURL1, String lessonURL2, String videoId) {
        this.courseID = courseID;
        this.lessonID = lessonID;
        this.lessonNumber = lessonNumber;
        this.lessonName = lessonName;
        this.description = description;
        this.youtubeURL = youtubeURL;
        this.youtubeText = youtubeText;
        this.lessonURL1 = lessonURL1;
        this.lessonURL2 = lessonURL2;
        this.videoId = videoId;
    }

    public Lesson(int courseID, int lessonID, int lessonNumber, String lessonName, String description, String youtubeURL, String youtubeText, String lessonURL1, String lessonURL2) {
        this.courseID = courseID;
        this.lessonID = lessonID;
        this.lessonNumber = lessonNumber;
        this.lessonName = lessonName;
        this.description = description;
        this.youtubeURL = youtubeURL;
        this.youtubeText = youtubeText;
        this.lessonURL1 = lessonURL1;
        this.lessonURL2 = lessonURL2;
    }

    public int getLessonID() {
        return lessonID;
    }

    public void setLessonID(int lessonID) {
        this.lessonID = lessonID;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public int getLessonNumber() {
        return lessonNumber;
    }

    public void setLessonNumber(int lessonNumber) {
        this.lessonNumber = lessonNumber;
    }

    public String getLessonName() {
        return lessonName;
    }

    public void setLessonName(String lessonName) {
        this.lessonName = lessonName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getYoutubeURL() {
        return youtubeURL;
    }

    public void setYoutubeURL(String youtubeURL) {
        this.youtubeURL = youtubeURL;
    }

    public String getYoutubeText() {
        return youtubeText;
    }

    public void setYoutubeText(String youtubeText) {
        this.youtubeText = youtubeText;
    }

    public String getLessonURL1() {
        return lessonURL1;
    }

    public void setLessonURL1(String lessonURL1) {
        this.lessonURL1 = lessonURL1;
    }

    public String getLessonURL2() {
        return lessonURL2;
    }

    public void setLessonURL2(String lessonURL2) {
        this.lessonURL2 = lessonURL2;
    }
}
