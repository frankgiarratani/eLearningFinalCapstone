package com.techelevator.dao;

import com.techelevator.model.Assignment;
import com.techelevator.model.Course;
import com.techelevator.model.Lesson;
import com.techelevator.model.Student;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import java.security.Principal;
import java.util.List;

public interface CourseDao {

    List<Course> getAllCourses();

    Course getCourseById(int courseID);

    Course createCourse(Course newCourse, String username);

    Lesson createLesson(Lesson newLesson, Integer courseID);

    List<Lesson> getLessons(Integer courseID);

//    Lesson getLessonForLessonID(Integer lessonID);

    String getTeacher(Integer courseID);

    Course getCourseInfo(Integer courseID);

    Assignment createAssignment(Assignment newAssignment, Integer courseID);

    List<Assignment> getAssignments(Integer courseID);

    Assignment getAssignmentForAssignmentID(Integer assignmentID, Integer studentID);

    void registerStudentInCourse(String username, int courseID);

    List<Course> getMyEnrolledCourses(String username);

    List<Course> getMyCoursesToTeach(String username);

    List<Assignment> getMyGradedAssignments(String username);

    Lesson getFullLessonForLessonID(String username, Integer lessonID);

    int getTeacherID(String username);


    int getStudentID(String username);


    boolean checkIfStudentIsRegistered(int courseID, int studentID);


    boolean checkIfTeacherIsCourseTeacher(int courseID, int teacherID);


   Lesson setVideoAndGoogleLessonForID(Integer lessonID, Integer courseID, Lesson lesson);






    void setSubmittedAssignmentInfo(String username, Integer assignmentID, Assignment assignment);


    void setSubmittedAssignmentInfo(String username, Integer assignmentID, String submission);




        void gradeAndReviewAssignment(String username, Integer assignmentID, Assignment assignment);


    List<Student> getAllStudentsInCourse(Integer courseID);

    List<Assignment> getAllStudentsAssignments(Integer courseID);

//    List<Assignment> getUngradedButSubmitted(String username);



//    public Integer getLessonIDForYoutube(int lessonNumber, int courseID);

}
