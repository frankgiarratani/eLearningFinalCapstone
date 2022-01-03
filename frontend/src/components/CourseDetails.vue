<template>
  <div class="body">
    <br>
    <label class="course-name">Course name:</label>
    <h1>{{courseInfo.title}}</h1>

    <br>

    Teacher name:
    <h3>{{teacherName}}</h3>

    <br>

    Description:
    <h4>{{courseInfo.description}}</h4>

    <br>

    <h2>Course lessons:</h2>
    <div class="card-details" v-for="lesson in lessons" v-bind:key="lesson.lessonID">
      <span class="bold-me"> Lesson: {{lesson.lessonNumber}} </span>
      <br>
      <router-link v-bind:to="{ name: 'lesson', params: { courseID: lesson.courseID, lessonID : lesson.lessonID } }">
         Topic: {{lesson.lessonName}}
         <br>
      </router-link>
      Description: {{lesson.description}}
      <br>
      <br>
    </div>

    <h2>Assignments</h2>
    <div class="card-details" v-for="assignment in assignments" v-bind:key="assignment.assignmentID">
      <span class="bold-me"> Number: {{assignment.assignmentNumber}} </span>
      <br>
      <router-link v-bind:to="{ name: 'assignment-student', params: { courseID: assignment.courseID, assignmentID : assignment.assignmentID} }">
        Name: {{assignment.assignmentName}}
        <br>
      </router-link>
      Description: {{assignment.description}}
      <br>
      Possible points: {{assignment.possiblePoints}}
      <br>
      Due date: {{assignment.dueDate}}
      <br>
      <!-- <div v-show="!isTeacher">Submitted: {{assignment.graded ? "Yes" : "No"}}</div>
      <div v-show="!isTeacher">Graded: {{assignment.submitted ? "Yes" : "No"}}</div> -->
      <br>
    </div>

    <br>

    <h3 v-show="isTeacher">Forms for teacher to add course lessons and homework:</h3>

    <br>
    
    <button v-if="!showAssignmentForm" v-on:click="showAssignmentForm = !showAssignmentForm" v-show="isTeacher">Add New Assignment</button>
      <form v-on:submit.prevent="saveNewAssignment" v-if="showAssignmentForm">
        <h3>Add New Assignment:</h3>
        <br>
        Assignment Number:
        <input type="number" v-model="newAssignment.assignmentNumber" />
        <br>
        Assignment Name:
        <input type="text" v-model="newAssignment.assignmentName" />
        <br>
        Assignment Description:
        <input type="text" v-model="newAssignment.description" />
        <br>
        Possible points:
        <input type="number" v-model="newAssignment.possiblePoints" />
        <br>
        Due date:
        <input type="date" v-model="newAssignment.dueDate" />
        <br>

        <button type="submit">Save</button>
        <button v-on:click.prevent="resetAssignment">Cancel</button>
        <br>
      </form>

      <br>
      <br>

    <button v-if="!showLessonForm" v-on:click="showLessonForm = !showLessonForm" v-show="isTeacher">Add New Lesson</button>
      <form v-on:submit.prevent="saveNewLesson" v-if="showLessonForm">
        <h3>Add New Lesson:</h3>
        <br>
        Lesson Number:
        <input type="number" v-model="newLesson.lessonNumber" />
        <br>
        Lesson Name:
        <input type="text" v-model="newLesson.lessonName" />
        <br>
        Lesson Description:
        <input type="text" v-model="newLesson.description" />
        <br>

        <button type="submit">Save</button>
        <button v-on:click.prevent="resetLesson">Cancel</button>
      </form>

  </div>
</template>

<script>
import courseService from '../services/CourseService';

export default {
  name: 'course-details',

  props: ['isTeacher'],

  data() {
    return {
        lessons: [],
        assignments: [],
        teacherName: '',
        courseInfo: {},
        courseID: this.$route.params.courseID,
        newAssignment: {},
        newLesson: {},
        showAssignmentForm: false,
        showLessonForm: false
    }
  },
  
  created() {
    this.getAssignments(this.courseID);
    this.getLessons(this.courseID);
    this.getTeacherName(this.courseID);
    this.getCourseInfo(this.courseID);
  },

  methods: {
    getAssignments(courseID) {
      courseService
        .getAssignments(courseID)
        .then(response => {
          this.assignments = response.data;
        })
        .catch(error => {
          if (error.response) {
            this.errorMsg = `Error retrieving. Response received was ' ${error.response.statusText}'.`;                "'.";
          } else if (error.request) {
            this.errorMsg = "Error retrieving. Server could not be reached.";
          } else {
            this.errorMsg = "Error retreiving. Request could not be created.";
          }
        });
    },

    getLessons(courseID) {
      courseService
        .getLessons(courseID)
        .then(response => {
          this.lessons = response.data;
        })
        .catch(error => {
          if (error.response) {
            this.errorMsg = `Error retrieving. Response received was ' ${error.response.statusText}'.`;                "'.";
          } else if (error.request) {
            this.errorMsg = "Error retrieving. Server could not be reached.";
          } else {
            this.errorMsg = "Error retreiving. Request could not be created.";
          }
        });
    },

    saveNewAssignment() {
      courseService
        .addAssignment(this.newAssignment, this.courseID)
        .then(response => {
          if(response && response.status == 201) {
          this.getAssignments(this.courseID);
          this.resetAssignment();
        }
      })
      .catch(error => {
        // log the error
        if (error.response) {
          this.errorMsg = "Error submitting new course. Response received was '" + error.response.statusText + "'.";
        } else if (error.request) {
          this.errorMsg = "Error submitting new course. Server could not be reached.";
        } else {
          this.errorMsg = "Error submitting new course. Request could not be created.";
        }
        });
    },

    saveNewLesson() {
      courseService
        .addLesson(this.newLesson, this.courseID)
        .then(response => {
          if(response && response.status == 201) {
          this.getLessons(this.courseID);
          this.resetLesson();
        }
      })
      .catch(error => {
        // log the error
        if (error.response) {
          this.errorMsg = "Error submitting new course. Response received was '" + error.response.statusText + "'.";
        } else if (error.request) {
          this.errorMsg = "Error submitting new course. Server could not be reached.";
        } else {
          this.errorMsg = "Error submitting new course. Request could not be created.";
        }
        });
    },

    resetAssignment() {
      this.newAssignment = {};
      this.showAssignmentForm = false;
    },

    resetLesson() {
      this.newLesson = {};
      this.showLessonForm = false;
    },

    getCourseInfo(courseID) {
      courseService
        .getCourseInfo(courseID)
        .then(response => {
          this.courseInfo = response.data;
        })
        .catch(error => {
          if (error.response) {
            this.errorMsg = `Error retrieving. Response received was ' ${error.response.statusText}'.`;                "'.";
          } else if (error.request) {
            this.errorMsg = "Error retrieving. Server could not be reached.";
          } else {
            this.errorMsg = "Error retreiving. Request could not be created.";
          }
        });
    },

    getTeacherName(courseID) {
      courseService
        .getTeacherName(courseID)
        .then(response => {
          this.teacherName = response.data;
        })
        .catch(error => {
          if (error.response) {
            this.errorMsg = `Error retrieving. Response received was ' ${error.response.statusText}'.`;                "'.";
          } else if (error.request) {
            this.errorMsg = "Error retrieving. Server could not be reached.";
          } else {
            this.errorMsg = "Error retreiving. Request could not be created.";
          }
        });
    }

  }

}
</script>

<style>

.course-name {
  margin-top: 30px;
}
.card-details {
background-image: linear-gradient(to bottom right, rgba(0, 0, 0, 0.315), rgb(68, 68, 68));
border-style: solid;
border-width: 1px;
border-radius: 8px;
box-shadow: 0px 0px 100px rgba(8, 8, 8, 0.144);
margin-top: 15px;
padding-bottom: 0%;
padding-left: 10px;
padding-bottom: auto;
font-family: sans-serif;
}

.card-details:hover {
font-size: 101%;
}

.bold-me {
  font-weight: bold;
}

form > label, form > input {
  display: block;
}
</style>