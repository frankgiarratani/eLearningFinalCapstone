package com.techelevator.model;

import com.techelevator.dao.CourseDao;
import com.techelevator.dao.UserDao;

import java.security.Principal;

public class CourseAuthorization {

    private final Principal principal;
    private final int courseID;
    private final UserDao userDao;
    private final CourseDao courseDao;

    public CourseAuthorization(Principal principal, int courseID, UserDao userDao, CourseDao courseDao) {
        this.principal = principal;
        this.courseID = courseID;
        this.userDao = userDao;
        this.courseDao = courseDao;
        System.out.println("Course Authorization activated!");
    }

    public boolean isAllowedToView() {

        String username = principal.getName();
        System.out.println("Username: " + username);
        int userID = userDao.findIdByUsername(username);
        System.out.println("User ID: " + userID);
        int studentID = 0;
        int teacherID = 0;

        boolean isTeacher = userDao.findIfUsernameIsTeacher(username);
        System.out.println("isTeacher?: " + isTeacher);
        boolean accessGranted = false;

        if (isTeacher) {
            teacherID = courseDao.getTeacherID(username);
            System.out.println("I am a teacher");
            accessGranted = courseDao.checkIfTeacherIsCourseTeacher(courseID, teacherID);

        } else {
            studentID = courseDao.getStudentID(username);
            System.out.println("I am a student");
            accessGranted = courseDao.checkIfStudentIsRegistered(courseID, studentID);

        }
        System.out.println("Access granted: " + accessGranted);

        return accessGranted;

    }

    public boolean isAllowedToGrade() {

        String username = principal.getName();
        System.out.println("Username: " + username);
        int userID = userDao.findIdByUsername(username);
        System.out.println("User ID: " + userID);
        int studentID = 0;
        int teacherID = 0;

        boolean isTeacher = userDao.findIfUsernameIsTeacher(username);
        System.out.println("isTeacher?: " + isTeacher);
        boolean accessGranted = false;

        if (isTeacher) {
            teacherID = courseDao.getTeacherID(username);
            System.out.println("I am a teacher");
            accessGranted = courseDao.checkIfTeacherIsCourseTeacher(courseID, teacherID);

        } else {
            System.out.println("I am a student");
            accessGranted = false;

        }
        System.out.println("Access granted: " + accessGranted);

        return accessGranted;

    }

    public boolean isAllowedToSubmitAssignment() {

        String username = principal.getName();
        //System.out.println("Username: " + username);
        int userID = userDao.findIdByUsername(username);
        //System.out.println("User ID: " + userID);
        int studentID = 0;

        boolean isTeacher = userDao.findIfUsernameIsTeacher(username);
        //System.out.println("isTeacher?: " + isTeacher);
        boolean accessGranted = false;

        if (isTeacher) {
            //System.out.println("I am a teacher");
            accessGranted = false;

        } else {
            studentID = courseDao.getStudentID(username);
            //System.out.println("I am a student");
            accessGranted = courseDao.checkIfStudentIsRegistered(courseID, studentID);

        }
        System.out.println("Access granted: " + accessGranted);

        return accessGranted;

    }
}
