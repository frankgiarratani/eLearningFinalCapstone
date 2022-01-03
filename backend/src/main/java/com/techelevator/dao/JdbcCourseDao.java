package com.techelevator.dao;

import com.techelevator.model.*;
import org.apache.tomcat.jni.Local;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;

import java.security.Principal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcCourseDao implements CourseDao {

    private final JdbcTemplate jdbcTemplate;

    public JdbcCourseDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }


    /*------ Course Methods ------*/

    @Override
    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<Course>();
        SqlRowSet results = jdbcTemplate.queryForRowSet("SELECT course_id, course_name, course_description, difficulty_level, course_cost FROM courses");
        while(results.next()) {
            Course course = mapRowToCourse(results);
            courses.add(course);
        }
        return courses;
    }

    @Override
    public Course getCourseById(int courseID) {
        Course testCourse = new Course("Java 101", courseID);
        return testCourse;
    }

    @Override
    public Course getCourseInfo(Integer courseID) {
        Course course = new Course();
        String sql = "SELECT course_id, course_name, course_description, difficulty_level, course_cost FROM courses WHERE course_id = ?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, courseID);

        while(results.next()) {
            course = mapRowToCourse(results);
        }
        return course;
    }

    @Override
    public List<Course> getMyEnrolledCourses(String username) {
        List<Course> myCourseList = new ArrayList<>();
        int studentID = getStudentID(username);
        SqlRowSet results = jdbcTemplate.queryForRowSet("SELECT course_id, course_name, course_description, difficulty_level, course_cost FROM courses JOIN student_courses USING (course_id) WHERE student_id = ?", studentID);
        while(results.next()) {
            Course course = mapRowToCourse(results);
            myCourseList.add(course);
        }
        return myCourseList;
    }

    @Override
    public List<Course> getMyCoursesToTeach(String username) {
        List<Course> myCourseList = new ArrayList<>();
        int teacherID = getTeacherID(username);
        SqlRowSet results = jdbcTemplate.queryForRowSet("SELECT course_id, course_name, course_description, difficulty_level, course_cost FROM courses JOIN teacher_courses USING (course_id) WHERE teacher_id = ?", teacherID);
        while(results.next()) {
            Course course = mapRowToCourse(results);
            myCourseList.add(course);
        }
        return myCourseList;
    }

    @Override
    public Course createCourse(Course newCourse, String username) {

        String sql = "INSERT INTO courses (course_name, course_description, difficulty_level, course_cost) VALUES (?, ?, ?, ?);";

        String course_name = newCourse.getTitle();
        String course_description = newCourse.getDescription();
        int difficulty_level = newCourse.getDifficultyLevel();
        double course_cost = newCourse.getCost();

        //QueryForRowSet ... RETURNING course_id... capture row set that comes back, advance cursor, grab that number

        jdbcTemplate.update(sql, course_name, course_description, difficulty_level, course_cost);
        String sql3 = "SELECT MAX(course_id) FROM courses;";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql3);
        int courseID = 0;
        if (results.next()) {
            courseID = results.getInt("max");

        }
        int teacherID = getTeacherID(username);

        createTeacherCourse(teacherID, courseID);
        newCourse.setCourseID(courseID);
        return newCourse;
    }

    public void registerStudentInCourse(String username, int courseID) {
        int studentID = getStudentID(username);

        String sql = "INSERT INTO student_courses (student_id, course_id) VALUES (?, ?);";
        jdbcTemplate.update(sql, studentID, courseID);

        String sql4 = "SELECT assignment_id, possible_points FROM assignments WHERE course_id = ?;";

        SqlRowSet assignments = jdbcTemplate.queryForRowSet(sql4, courseID);
        while (assignments.next()) {
            int assignmentID = assignments.getInt("assignment_id");
            int possiblePoints = assignments.getInt("possible_points");
            String sql2 = "INSERT INTO student_assignments (student_id, homework_id, possible_points, is_submitted, is_graded) VALUES(?, ?, ?, false, false);";


            jdbcTemplate.update(sql2, studentID, assignmentID, possiblePoints);
        }



    }

    public void createTeacherCourse(int teacherID, int courseID) {
        String sql2 = "INSERT INTO teacher_courses (teacher_id, course_id)" +
                " VALUES(?, ?);";
        jdbcTemplate.update(sql2, teacherID, courseID);
    }



    /*------ Lesson Methods ------*/

    @Override
    public Lesson createLesson(Lesson newLesson, Integer courseID) {
        String sql = "INSERT INTO lessons (lesson_number, lesson_name, description, course_id) " +
                "VALUES (?, ?, ?, ?);";

        int lessonNumber = newLesson.getLessonNumber();
        String lessonName = newLesson.getLessonName();
        String description = newLesson.getDescription();

        jdbcTemplate.update(sql, lessonNumber, lessonName, description, courseID);

        return newLesson;
    }

    @Override
    public List<Lesson> getLessons(Integer courseID) {
        List<Lesson> lessons = new ArrayList<>();
        String sql = "SELECT lesson_number, lesson_id, lesson_name, description FROM lessons WHERE course_id = ?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, courseID);

        while (results.next()) {
            // changed from mapRowToLesson to mapRowToLessonLite by James at 7:20pm on Mon 12-13
            Lesson lesson = mapRowToLessonLite(results);
            lesson.setCourseID(courseID);
            lessons.add(lesson);
        }

        return lessons;
    }

//    @Override
//    public Lesson getLessonForLessonID(Integer lessonID) {
//        Lesson lesson = new Lesson();
//        String sql = "SELECT lesson_number, lesson_id, lesson_name, description FROM lessons WHERE lesson_id = ?";
//        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, lessonID);
//
//        while (results.next()) {
//            lesson = mapRowToLessonLite(results);
//        }
//        return lesson;
//    }

    @Override
    public Lesson getFullLessonForLessonID(String username, Integer lessonID) {
        System.out.println("I'm in getFullLessonForLessonID");
        System.out.println("Username: " + username);
        System.out.println("LessonID: " + lessonID);
        Lesson lesson = new Lesson();
        String sql = "SELECT course_id, lesson_number, lesson_id, lesson_name, description, " +
                "youtube_url, youtube_text, lesson_url1, lesson_url2 " +
                "FROM lessons WHERE lesson_id = ?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, lessonID);

        if (results.next()) {
            lesson = mapRowToLesson(results);
        }
        String youtubeURL = lesson.getYoutubeURL();

//        if(youtubeURL != null) {
//            String vidKey = parseVidID(youtubeURL);
//            lesson.setVideoId(vidKey);
//            lesson.setVideoId(vidKey);
//        }
//        String vidKey = parseVidID(lesson.getYoutubeURL());
//        lesson.setVideoId(vidKey);
        return lesson ;
    }

    @Override
    public Lesson setVideoAndGoogleLessonForID(Integer lessonID, Integer courseID, Lesson lesson) {
//        int lessonID = getLessonIDForYoutube(lessonNumber, courseID);

        String youtubeURL = lesson.getYoutubeURL();
        String youtubeText = lesson.getYoutubeText();
        String lessonURL1 = lesson.getLessonURL1();
        String lessonURL2 = lesson.getLessonURL2();

//        if(youtubeURL != null) {
//            String vidKey = parseVidID(youtubeURL);
//            lesson.setVideoId(vidKey);
//        }


        String sql = "Update lessons SET youtube_url = ?, youtube_text = ?, lesson_url1 = ?, lesson_url2 = ? WHERE lesson_id = ?;";
        jdbcTemplate.update(sql, youtubeURL, youtubeText, lessonURL1, lessonURL2, lessonID);




        return lesson;
    }

    @Override
    public void setSubmittedAssignmentInfo(String username, Integer assignmentID, Assignment assignment) {

    }










    /*------ Assignment Methods ------*/

    @Override
    public Assignment createAssignment(Assignment newAssignment, Integer courseID) {
        String sql = "INSERT INTO assignments (course_id, assignment_number, assignment_name, description, " +
                "possible_points, due_date) VALUES (?, ?, ?, ?, ?, ?);";

        int assignmentNumber = newAssignment.getAssignmentNumber();
        String assignmentName = newAssignment.getAssignmentName();
        String description = newAssignment.getDescription();
        int possiblePoints = newAssignment.getPossiblePoints();
        LocalDate dueDate = newAssignment.getDueDate();

        jdbcTemplate.update(sql, courseID, assignmentNumber, assignmentName, description, possiblePoints, dueDate);

        String sql3 = "SELECT MAX(assignment_id) FROM assignments;";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql3);
        int assignmentID = 0;
        if (results.next()) {
            assignmentID = results.getInt("max");

        }

        String sql4 = "SELECT student_id FROM student_courses WHERE course_id = ?;";

        SqlRowSet students = jdbcTemplate.queryForRowSet(sql4, courseID);
        int studentID = 0;
        while (students.next()) {
            studentID = students.getInt("student_id");
            String sql2 = "INSERT INTO student_assignments (student_id, homework_id, possible_points, is_submitted, is_graded) VALUES(?, ?, ?, false, false);";


            jdbcTemplate.update(sql2, studentID, assignmentID, possiblePoints);
        }

//        String sql2 = "INSERT INTO student_assignments (student_id, homework_id, possible_points, is_submitted, is_graded) VALUES(?, ?, ?, false, false);";
//
//
//        jdbcTemplate.update(sql2, assignmentID, possiblePoints, courseID);


        return newAssignment;
    }

    @Override
    public Assignment getAssignmentForAssignmentID(Integer assignmentID, Integer studentID) {
        Assignment assignment = new Assignment();
        String sql = "SELECT course_id, assignment_id, assignment_number, assignment_name, description, " +
                "assignments.possible_points, due_date, student_id, homework_id, student_grade, submission, " +
                "teacher_feedback, submission_date_time, is_submitted, is_graded " +
                "FROM student_assignments LEFT JOIN assignments ON (homework_id = assignment_id)" +
                "WHERE assignment_id = ? and student_id = ?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, assignmentID, studentID);

        if (results.next()) {
            assignment = mapRowToAssignment(results);
        }
        return assignment;
    }

    @Override
    public List<Assignment> getAssignments(Integer courseID) {

        List<Assignment> assignments = new ArrayList<>();

        String sql = "SELECT course_id, assignment_id, assignment_number, assignment_name, description, " +
                "assignments.possible_points, due_date FROM assignments " +
                "WHERE course_id = ? ORDER BY assignment_number;";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, courseID);

        while (results.next()) {
            Assignment assignment = mapRowToAssignmentLite(results);
            assignments.add(assignment);
        }

        return assignments;
    }

    @Override
    public List<Assignment> getMyGradedAssignments(String username) {
        int studentID = getStudentID(username);
        List<Assignment> assignments = new ArrayList<>();
        String sql = "SELECT course_id, assignment_id, assignment_number, assignment_name, description, " +
                "assignments.possible_points, due_date, student_id, homework_id, student_grade, submission, " +
                "teacher_feedback, submission_date_time, is_submitted, is_graded FROM student_assignments " +
                "JOIN assignments ON (assignment_id = homework_id) WHERE student_id = ? " +
                "AND is_graded = true";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, studentID);

        while (results.next()) {
            Assignment assignment = mapRowToAssignment(results);
            assignments.add(assignment);
        }

        return assignments;
    }

    @Override
    public void setSubmittedAssignmentInfo(String username, Integer assignmentID, String submission) {
        System.out.println("Inside setSubmittedAssignmentInfo");

        LocalDate submissionDateTime = LocalDate.now();
        boolean isSubmitted = true;
        boolean isGraded = false;
        int studentID = getStudentID(username);

        System.out.println(username + " " + assignmentID + " " + submission + " " + studentID + " " + submissionDateTime );
        String sql = "UPDATE student_assignments SET submission = ?, " +
                "submission_date_time = ?, is_submitted = ?, is_graded = ? WHERE homework_id = ? AND student_id = ?";
        jdbcTemplate.update(sql, submission, submissionDateTime, isSubmitted, isGraded, assignmentID, studentID);

    }


    @Override
    public void gradeAndReviewAssignment(String username, Integer assignmentID, Assignment assignment) {
        System.out.println("Inside gradeAndReviewAssignment");
        double studentGrade = assignment.getStudentGrade();
        String teacherFeedback = assignment.getTeacherFeedback();
        boolean isGraded = true;
        int studentID = assignment.getStudentID();
        System.out.println(studentGrade + " " + teacherFeedback + " " + isGraded  + " " + assignmentID  + " " + studentID);
        String sql = "UPDATE student_assignments SET student_grade = ?, " +
                "teacher_feedback = ?, is_graded = ? WHERE homework_id = ? AND student_id = ?";
        jdbcTemplate.update(sql, studentGrade, teacherFeedback, isGraded, assignmentID, studentID);

    }

    @Override
    public List<Assignment> getAllStudentsAssignments(Integer courseID) {
        List<Assignment> assignments = new ArrayList<>();
        String sql = "SELECT course_id, assignment_id, assignment_number, assignment_name, description, " +
                "assignments.possible_points, due_date, student_grade, submission, teacher_feedback, is_graded, " +
                "is_submitted, submission_date_time, student_id FROM assignments " +
                "RIGHT JOIN student_assignments ON assignments.assignment_id = student_assignments.homework_id " +
                "WHERE course_id = ?;";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, courseID);

        while (results.next()) {
            Assignment assignment = mapRowToAssignment(results);
            assignments.add(assignment);
        }

        return assignments;
    }

//    @Override
//    public List<Assignment> getUngradedButSubmitted(String username) {
//        List<Assignment> assignments = new ArrayList<>();
//
//        int teacherID = getTeacherID(username);
//
//        String sql = "SELECT student_id, first_name, last_name, assignment_number, possible_points, is_submitted, is_graded FROM" +
//                "assignments JOIN students USING(student_id) JOIN courses USING (course_id) JOIN teacher_courses USING (courseID) WHERE is_submitted = true AND is_graded = false AND teacherID = ? ORDER BY course_id;";
//
//        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, teacherID);
//
//        while (results.next()) {
//            Assignment assignment = mapRowToAssignment(results);
//            assignments.add(assignment);
//        }
//
//        return assignments;
//
//
//    }


    /*------ Student Methods ------*/
    public List<Student> getAllStudentsInCourse(Integer courseID) {

        List<Student> students = new ArrayList<>();
        String sql = "SELECT users.first_name, users.last_name, student_id, username FROM students " +
                "JOIN student_courses USING (student_id) JOIN users USING (user_id) WHERE course_id = ?";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, courseID);

        while (results.next()) {
            Student student = mapRowToStudent(results);
            // changed from mapRowToLesson to mapRowToLessonLite by James at 7:20pm on Mon 12-13
            students.add(student);
        }

        return students;

    }



    /*------ Helper Methods ------*/
    @Override
    public int getStudentID(String username) {
        String sql = "SELECT student_id FROM students JOIN users USING( user_id) WHERE username = ?;";
        int studentID = 0;
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, username);
        if (results.next()) {
            studentID = results.getInt("student_id");
        }
        return studentID;
    }

    @Override
    public int getTeacherID(String username) {
        String sql = "SELECT teacher_id FROM teachers JOIN users USING( user_id) WHERE username = ?;";
        int teacherID = 0;
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, username);
        if (results.next()) {
            teacherID = results.getInt("teacher_id");

        }

        return teacherID;

    }

    @Override
    public String getTeacher(Integer courseID) {

        String sql = "SELECT first_name, last_name FROM teachers JOIN teacher_courses USING (teacher_id) WHERE course_id = ?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, courseID);
        String firstName = "";
        String lastName = "";
        while (results.next()) {
            firstName = results.getString("first_name");
            lastName = results.getString("last_name");
        }
        return firstName + " " + lastName;

    }

    public String parseVidID(String youtubeURL) {
        int index = youtubeURL.indexOf("v=");
        return youtubeURL.substring(index+2);
    }


//    public Integer getLessonIDForYoutube(int lessonNumber, int courseID) {
//        String sql = "SELECT lesson_id FROM lessons WHERE lesson_number = ? AND course_id = ?;";
//        int lessonID = 0;
//        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, lessonNumber, courseID);
//        if (results.next()) {
//            lessonID = results.getInt("lesson_id");
//
//        }
//        return lessonID;
//    }


    @Override
    public boolean checkIfStudentIsRegistered(int courseID, int studentID) {
        int count = jdbcTemplate.queryForObject("SELECT COUNT(student_id) FROM student_courses " +
                "WHERE student_id=? AND course_id=?;", int.class, studentID, courseID);
        System.out.println("COUNT: " + count);
        if (count == 1)
            return true;
        else
            return false;
    }

    @Override
    public boolean checkIfTeacherIsCourseTeacher(int courseID, int teacherID) {
        int count = jdbcTemplate.queryForObject("SELECT COUNT(teacher_id) FROM teacher_courses " +
                "WHERE teacher_id=? AND course_id=?;", int.class, teacherID, courseID);
        System.out.println("COUNT: " + count);
        if (count == 1)
            return true;
        else
            return false;
    }




    /*------ Database Row Set Methods ------*/


    //        String sql = "SELECT lesson_number, lesson_id, lesson_name, description, " +
    //                "youtube_url, youtube_text, lesson_url1, lesson_url2 " +
    //                "FROM lessons WHERE lesson_id = ?";


    private Lesson mapRowToLesson(SqlRowSet rs) {
        return new Lesson(
                rs.getInt("course_id"),
                rs.getInt("lesson_number"),
                rs.getInt("lesson_id"),
                rs.getString("lesson_name"),
                rs.getString("description"),
                rs.getString("youtube_url"),
                rs.getString("youtube_text"),
                rs.getString("lesson_url1"),
                rs.getString("lesson_url2"));
    }

    private Lesson mapRowToLessonLite(SqlRowSet rs) {
        return new Lesson(
                rs.getInt("lesson_id"),
                rs.getInt("lesson_number"),
                rs.getString("lesson_name"),
                rs.getString("description"));
    }

    private Assignment mapRowToAssignment(SqlRowSet rs) {
        Assignment assignment = new Assignment();

        // from Assignments table
        assignment.setCourseID(rs.getInt("course_id"));
        assignment.setAssignmentID(rs.getInt("assignment_id"));
        assignment.setAssignmentNumber(rs.getInt("assignment_number"));
        assignment.setAssignmentName(rs.getString("assignment_name"));
        assignment.setDescription(rs.getString("description"));
        assignment.setPossiblePoints(rs.getInt("possible_points"));
        if(rs.getDate("due_date") != null) {
            assignment.setDueDate(rs.getDate("due_date").toLocalDate());
        }

        // from student_assignments table
        assignment.setStudentGrade(rs.getDouble("student_grade"));
        assignment.setSubmission(rs.getString("submission"));
        assignment.setTeacherFeedback(rs.getString("teacher_feedback"));
        assignment.setGraded(rs.getBoolean("is_graded"));
        assignment.setSubmitted(rs.getBoolean("is_submitted"));
        assignment.setStudentID(rs.getInt("student_id"));
        if(rs.getDate("submission_date_time") != null) {
            assignment.setSubmittedDateTime(rs.getDate("submission_date_time").toLocalDate());
        } else {
            assignment.setSubmittedDateTime(null);
        }

        return assignment;
    }

    private Assignment mapRowToAssignmentLite(SqlRowSet rs) {
        Assignment assignment = new Assignment();

        // from Assignments table
        assignment.setCourseID(rs.getInt("course_id"));
        assignment.setAssignmentID(rs.getInt("assignment_id"));
        assignment.setAssignmentNumber(rs.getInt("assignment_number"));
        assignment.setAssignmentName(rs.getString("assignment_name"));
        assignment.setDescription(rs.getString("description"));
        assignment.setPossiblePoints(rs.getInt("possible_points"));
//        assignment.setStudentID(rs.getInt("student_id"));
        if(rs.getDate("due_date") != null) {
            assignment.setDueDate(rs.getDate("due_date").toLocalDate());
        }

        return assignment;
    }

    private Course mapRowToCourse (SqlRowSet rs) {
        return new Course(rs.getString("course_name"),
                rs.getString("course_description"),
                rs.getInt("difficulty_level"),
                rs.getDouble("course_cost"),
                rs.getInt("course_id"));
    }

    private Student mapRowToStudent (SqlRowSet rs) {
        return new Student(rs.getString("first_name"),
                rs.getString("last_name"),
                rs.getLong("student_id"),
                rs.getString("username"));
    }

}

