package com.techelevator.controller;

import com.techelevator.dao.CourseDao;
import com.techelevator.dao.UserDao;
import com.techelevator.model.*;
import org.springframework.data.relational.core.sql.In;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/courses")
@PreAuthorize("isAuthenticated()")
@CrossOrigin
public class CourseController {

    private final CourseDao courseDao;
    private final UserDao userDao;

    public CourseController(CourseDao courseDao, UserDao userDao) {
        this.courseDao = courseDao;
        this.userDao = userDao;
    }

    // Endpoint #1: Get All Courses
    @RequestMapping(value = "", method = RequestMethod.GET)
    public List<Course> list() {
        return courseDao.getAllCourses();
    }

    // Endpoint #2: Create a Course
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(value = "", method = RequestMethod.POST)
    public void createCourse(@RequestBody Course course, Principal principal) {
        courseDao.createCourse(course, principal.getName());
    }

    // Endpoint #3: Get Assignments for a Specific Course
    @RequestMapping(value = "/{courseID}/assignments", method = RequestMethod.GET)
    public List<Assignment> getAssignments(@PathVariable Integer courseID) {
        return courseDao.getAssignments(courseID);
    }

    //Endpoint #4: Get Lessons for a Specific Course
    @RequestMapping(value = "/{courseID}/lessons", method = RequestMethod.GET)
    public List<Lesson> getLessons(@PathVariable Integer courseID) {
        return courseDao.getLessons(courseID);
    }

    //Endpoint #5: Get Course Info for a Specific Course
    @RequestMapping(value = "/{courseID}/info", method = RequestMethod.GET)
    public Course getCourseInfo(@PathVariable Integer courseID) {
        return courseDao.getCourseInfo(courseID);
    }

    //Endpoint #6: Get Teacher Name for a Specific Course
    @RequestMapping(value = "/{courseID}/teacher", method = RequestMethod.GET)
    public String getTeacher(@PathVariable Integer courseID) {
        return courseDao.getTeacher(courseID);
    }

    //Endpoint #7: Get Assignment Details for a Specific Assignment ID
    @RequestMapping(value = "/{courseID}/assignments/{assignmentID}/students/{studentID}", method = RequestMethod.GET)
    public Assignment getAssignmentForID(@PathVariable Integer assignmentID, @PathVariable Integer studentID) {
        return courseDao.getAssignmentForAssignmentID(assignmentID, studentID);
    }

//    //Endpoint #8: Get Lesson Details for a Specific Lesson ID
//    @RequestMapping(value = "/{courseID}/lessons/{lessonID}", method = RequestMethod.GET)
//    public Lesson getLessonForID(@PathVariable Integer lessonID) {
//        return courseDao.getLessonForLessonID(lessonID);
//    }

    //Endpoint #9: Create Assignment for a Specific Course
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(value = "/{courseID}/assignments", method = RequestMethod.POST)
    public void createAssignment(@RequestBody Assignment assignment, @PathVariable Integer courseID) {
        courseDao.createAssignment(assignment, courseID);
    }

    //Endpoint #10: Create a New Lesson for a Specific Course
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(value = "/{courseID}/lessons", method = RequestMethod.POST)
    public void createLesson(@RequestBody Lesson lesson, @PathVariable Integer courseID) {
        courseDao.createLesson(lesson, courseID);
    }

    //Endpoint #11: Register Student for Specific Course
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(value = "/{courseID}/register", method = RequestMethod.POST)
    public void registerStudentInCourse(Principal principal, @PathVariable Integer courseID) {
        courseDao.registerStudentInCourse(principal.getName(), courseID);
    }

    //Endpoint #12: Return List of Enrolled Courses for Logged In Student
    @RequestMapping(value = "/myEnrolledCourses", method = RequestMethod.GET)
    public List<Course> getMyEnrolledCourses(Principal principal) {
        return courseDao.getMyEnrolledCourses(principal.getName());
    }

    //Endpoint #13: Return List of a Logged In Teacher's Courses
    @RequestMapping(value = "/myCoursesToTeach", method = RequestMethod.GET)
    public List<Course> getMyCoursesToTeach(Principal principal) {
        return courseDao.getMyCoursesToTeach(principal.getName());
    }

    //Endpoint #14: Return List of Upcoming Assignments for Logged In Student
    //@RequestMapping(value = "/myUpcomingAssignments", method = RequestMethod.GET)
    //    return axios.get(`courses/myUpcomingAssignments`)


    //Endpoint #15: Return List of Upcoming Lessons for Logged In Student
    //@RequestMapping(value = "/myUpcomingLessons", method = RequestMethod.GET)
    //    return axios.get(`courses/myUpcomingLessons`)


    //Endpoint #16: Return List of Graded Assignments for Logged In Student
    //@RequestMapping(value = "/myGradedAssignments", method = RequestMethod.GET)
    //    return axios.get(`courses/myGradedAssignments`)
    @RequestMapping(value = "/myGradedAssignments", method = RequestMethod.GET)
    public List<Assignment> getMyGradedAssignments(Principal principal) {
        return courseDao.getMyGradedAssignments(principal.getName());
    }

    //Endpoint #17: Return Full Lesson (With Content) for Lesson ID for Logged In Enrolled Student
    @RequestMapping(value = "/{courseID}/lessons/{lessonID}", method = RequestMethod.GET)
    public Lesson getFullLessonForID(Principal principal, @PathVariable Integer courseID, @PathVariable Integer lessonID) {
        System.out.println("I am in endpoint 17");
        CourseAuthorization courseAuth = new CourseAuthorization(principal, courseID, userDao, courseDao);
        if (courseAuth.isAllowedToView()) {
            System.out.println("Returning for " + principal.getName() + " Lesson: " + lessonID);
            return courseDao.getFullLessonForLessonID(principal.getName(), lessonID);
        } else {
            System.out.println("Access Denied, handle it somehow");
        }
        //look up course ID by lessonID
        //validateAuthorizationToViewCourseLessons(principal, courseID);
        Lesson dummy = new Lesson();
        System.out.println("returning dummy");
        return dummy;

    }


    //Endpoint #18: Set Youtube video for a Specific Lesson ID
    @RequestMapping(value = "/{courseID}/lessons/{lessonID}", method = RequestMethod.PUT)
    public Lesson setVideoAndGoogleLessonForID(@PathVariable Integer lessonID, @PathVariable Integer courseID, @RequestBody Lesson lesson) {
        return courseDao.setVideoAndGoogleLessonForID(lessonID, courseID, lesson);

    }


    //Endpoint #22: Submit Assignment for a specific Assignment ID


    //Endpoint #22: Submit an assignment (enrolled student only)

    @RequestMapping(value = "/{courseID}/assignments/{assignmentID}", method = RequestMethod.PUT)
    public void setSubmittedAssignmentDetails(Principal principal, @PathVariable Integer courseID,
                                              @PathVariable Integer assignmentID, @RequestBody String submission) {
        System.out.println("Inside Endpoint 22");
        //INSERT AUTH HERE
        CourseAuthorization courseAuth = new CourseAuthorization(principal, courseID, userDao, courseDao);
        if (courseAuth.isAllowedToSubmitAssignment()) {
            courseDao.setSubmittedAssignmentInfo(principal.getName(), assignmentID, submission);
        } else {
            System.out.println("Access Denied, handle it somehow");
        }
        //System.out.println(submission);
        courseDao.setSubmittedAssignmentInfo(principal.getName(), assignmentID, submission);
    }

    //Endpoint #23: Grade an assignment (teacher only)
    @RequestMapping(value = "/{courseID}/assignments/{assignmentID}/grades", method = RequestMethod.PUT)
    public void setAssignmentGrades(Principal principal, @PathVariable Integer courseID,
                                    @PathVariable Integer assignmentID, @RequestBody Assignment assignment) {
        System.out.println("Inside Endpoint 23");

        CourseAuthorization courseAuth = new CourseAuthorization(principal, courseID, userDao, courseDao);
        if (courseAuth.isAllowedToGrade()) {
            System.out.println("Returning for " + principal.getName() + " Assignment: " + assignmentID);
            courseDao.gradeAndReviewAssignment(principal.getName(), assignmentID, assignment);
        } else {
            System.out.println("Access Denied, handle it somehow");
        }

    }

    //Endpoint #24: Get all students in a course
    @RequestMapping(value = "/{courseID}/students", method = RequestMethod.GET)
    public List<Student> getAllStudentsInCourse(Principal principal, @PathVariable Integer courseID) {
        System.out.println("Inside Endpoint 24");
        CourseAuthorization courseAuth = new CourseAuthorization(principal, courseID, userDao, courseDao);
        if (courseAuth.isAllowedToGrade()) {
            return courseDao.getAllStudentsInCourse(courseID);
        } else {
            System.out.println("Access Denied, handle it somehow");
            return null;
        }
    }

    // Endpoint #25 AKA Endpoint #3 - The Remix: Get All Student Assignments for a Specific Course
    @RequestMapping(value = "/{courseID}/assignments/students", method = RequestMethod.GET)
    public List<Assignment> getStudentAssignments(Principal principal, @PathVariable Integer courseID) {
        System.out.println("Inside Endpoint 25");
        CourseAuthorization courseAuth = new CourseAuthorization(principal, courseID, userDao, courseDao);
        if (courseAuth.isAllowedToGrade()) {
            return courseDao.getAllStudentsAssignments(courseID);
        } else {
            System.out.println("Access Denied, handle it somehow");
            return null;
        }
    }

    // Endpoint ? get student ID by principal
    @RequestMapping(value = "/getStudentID", method = RequestMethod.GET)
    public int getStudentID(Principal principal) {
        return courseDao.getStudentID(principal.getName());
    }


//    @RequestMapping(value = "/myCoursesToTeach/forGrading", method = RequestMethod.GET)
//    public List<Assignment> getAssigmentsForGrading(Principal principal, Integer courseID) {
//        return courseDao.getUngradedButSubmitted(principal.getName());
//    }

    /*

    // Leaving this here because it might be a good model for authorization? Get a Specific Course by ID (Dummy)
    @RequestMapping(value="/{id}", method = RequestMethod.GET)
    public Course getCourse(@PathVariable Integer id, Principal principal) {
        Course course = courseDao.getCourseById(id);
        validateAuthorizationToView(principal, course);
        return course;
    }

    //Not currently using, but probably should be?
    private void validateAuthorizationToView(Principal principal, Course course) {
        CourseAuthorization auth = new CourseAuthorization(principal, course, userDao, courseDao);
        if(!auth.isAllowedToView()) {
            throw new AuthorizationException();
        }
    }


    //Not currently using, but probably should be?
    private void validateAuthorizationToViewCourseLessons(Principal principal, Course course) {
        CourseAuthorization auth = new CourseAuthorization(principal, course, userDao, courseDao);
        if(!auth.isAllowedToView()) {
            throw new AuthorizationException();
        }
    }
    */


}
