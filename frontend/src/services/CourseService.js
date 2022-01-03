import axios from 'axios';

export default {

  // Endpoint #1: Get All Courses
  getCourseData() {
    // this gets a list of all courses
    return axios.get('/courses');
  }, 

  // Endpoint #2: Create a Course
  addCourse(newCourse) {
    return axios.post('/courses', newCourse);
  },

  // Endpoint #3: Get Assignments for a Specific Course
  getAssignments(courseID) {
    return axios.get(`/courses/${courseID}/assignments`);
  },

  //Endpoint #4: Get Lessons for a Specific Course
  getLessons(courseID) {
    return axios.get(`/courses/${courseID}/lessons`);
  },

  //Endpoint #5: Get Course Info for a Specific Course
  getCourseInfo(courseID) {
    // returns a course object
    return axios.get(`/courses/${courseID}/info`);
  },

  //Endpoint #6: Get Teacher Name for a Specific Course
  getTeacherName(courseID) {
    // returns a string
    return axios.get(`/courses/${courseID}/teacher`);
  },

  //Endpoint #7: Get Assignment Details for a Specific Assignment ID
  getAssignmentDetails(courseID, assignmentID, studentID) {
    return axios.get(`/courses/${courseID}/assignments/${assignmentID}/students/${studentID}`);
  },

  //Endpoint #8: Get Lesson Details for a Specific Lesson ID
  getLessonDetails(courseID, lessonID, lesson) {
    return axios.get(`courses/${courseID}/lessons/${lessonID}`, lesson);
  },

  //Endpoint #9: Create Assignment for a Specific Course
  addAssignment(newAssignment, courseID) {
    return axios.post(`courses/${courseID}/assignments`, newAssignment);
  },

  //Endpoint #10: Create a New Lesson for a Specific Course
  addLesson(newLesson, courseID) {
    return axios.post(`courses/${courseID}/lessons`, newLesson);
  },

  //Endpoint #11: Register Student for Specific Course
  registerStudentForCourse(courseID) {
    // will need to use Principal on back-end to access studentID
    return axios.post(`courses/${courseID}/register`);
  },

  //Endpoint #12: Return List of Enrolled Courses for Logged In Student
  //@RequestMapping(value = "/myEnrolledCourses", method = RequestMethod.GET)
  getMyEnrolledCourses() {
    return axios.get(`courses/myEnrolledCourses`)
  },

  //Endpoint #13: Return List of a Logged In Teacher's Courses
  //@RequestMapping(value = "/myCoursesToTeach", method = RequestMethod.GET)
  getMyCoursesToTeach() {
    return axios.get(`courses/myCoursesToTeach`)
  },


  //Endpoint #16: Return List of Graded Assignments for Logged In Student
  // @RequestMapping(value = "/myGradedAssignments", method = RequestMethod.GET)
  getMyGradedAssignments() {
    return axios.get(`courses/myGradedAssignments`)
  },

  // //Endpoint #17: Return Full Lesson (With Content) for Lesson ID for Logged In Enrolled Student
  // getFullLesson() {
  //   return axios.get('courses/${courseID}/lessons/${lessonID}')
  // },


  //Endpoint #18: Update Assignment After Submission
  updateAssignmentDetails(updatedAssignment, assignmentID, courseID) {
    return axios.put(`courses/${courseID}/assignments`, updatedAssignment, assignmentID)
  },

  //Endpoint #19: Update Youtube URL to link back to specific Youtube Video for a particular lesson.
  setVideoAndGoogleLessonForID(courseID, lessonID, lesson) {
    return axios.put(`courses/${courseID}/lessons/${lessonID}`, lesson)
  },

  // //Endpoint #20 Update Google Doc URL to link back to specific Google Doc for a particular lesson.
  // updateLessonDoc(lesson, courseID, lessonID) {
  //   return axios.put(`/courses/${courseID}/lessons/${lessonID}/full`)
  // },

  // //Endpoint #21 Update Youtube Video Description to link back to a specific video description for a particular lesson.
  // updateVidDescription(lesson, courseID, lessonID) {
  //   return axios.put(`/courses/${courseID}/lessons/${lessonID}/full`)
  // },

  //Endpoint #22: Submit Assignment for a specific Assignment ID
  submitAssignment(submission, assignmentID, courseID) {
    return axios.put(`courses/${courseID}/assignments/${assignmentID}`, submission,
      {headers: {"Content-Type": "text/plain"}});
  },

  //Endpoint #23: Teacher grade an assignment
  gradeAssignment(updatedAssignment, assignmentID, courseID) {
    return axios.put(`courses/${courseID}/assignments/${assignmentID}/grades`, updatedAssignment)
  },

  //Endpoint #24: Get all students in a course
  getStudentsForCourse(courseID) {
    return axios.get(`courses/${courseID}/students`)
  },

  // Endpoint #25 
  getAssignmentsForCourse(courseID) {
    return axios.get(`courses/${courseID}/assignments/students`);
  },

  // Endpoint # ? get student ID by principal
  getStudentID() {
    return axios.get('courses/getStudentID');
  },

  //Endpoint # ? get ungraded assignments for teacher
  getMyUngradedAssignments() {
    return axios.get(`courses/myCoursesToTeach/forGrading`)
  }

}