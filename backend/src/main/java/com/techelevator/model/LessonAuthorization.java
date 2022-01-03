package com.techelevator.model;

import java.security.Principal;

public class LessonAuthorization {

    private final Principal principal;
    private final Lesson lesson;

    public LessonAuthorization(Principal principal, Lesson lesson) {
        this.principal = principal;
        this.lesson = lesson;
    }

    public boolean isAllowedToView() {

        //get principal username
        //if the user is a teacher, get teacherID
            //if teacherID is in
        //else get student ID
        //get student ID
        return true;
    }


}
