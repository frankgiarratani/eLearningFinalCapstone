<template>
  <div>
    <div class="card-details">
      
      <h3>{{assignment.assignmentName}}</h3>
      <h4>Assignment number: {{assignment.assignmentNumber}}</h4>
      <h4>Due: {{assignment.dueDate}}</h4>

      <h4>Grade: {{assignment.studentGrade}} </h4>
      <h4 v-show="assignment.graded">Teacher feedback: {{assignment.teacherFeedback}}</h4>
      <h4>Possible points: {{assignment.possiblePoints}}</h4>
      
      <h5>Description: {{assignment.description}}</h5>
      
    </div>
    
    
  
    <br>
    
    <form v-on:submit="gradeAssignment(assignment, assignmentID, courseID)" v-show="isTeacher">
        <h3>Feedback and grade:</h3>
        <input type="number" v-model="assignment.studentGrade">
        <input type="text" v-model="assignment.teacherFeedback" />
        <br>
        <button type="submit">Submit</button>
        <button v-on:click.prevent="resetFeedbackAndGradeForm">Cancel</button>
        <br>
        
      </form>
      <br>
    <div class="i-frame">
      <h4 v-show="assignment.submitted">Submission:</h4>
      <p><a href="v-bind=assignment.submission">{{assignment.submission}}</a></p>
      <iframe class="i-frame" v-show="assignment.submitted" width = 950px height = 1080px v-bind:src="assignment.submission"></iframe>
    

      <form class="is-teacher" v-if="!assignment.submitted" v-on:submit="submitAssignment(submission, assignmentID, courseID)" v-show="!isTeacher">
        <h3>Student submission:</h3>
        <h5>Copy and paste the link to your Google doc</h5>
        <input type="text" v-model="submission" />
        <br>
        <button type="submit">Submit</button>
        <button v-on:click.prevent="resetSubmission">Cancel</button>
        <br>
      </form>
  
      <br>

    </div>
    <br>

  </div>
</template>

<script>
import courseService from '../services/CourseService';

export default {
  name: 'assignment-details',

  props: ['isTeacher'],

  data() {
    return {
      assignment: {
        assignmentID:0, 
        assignmentName:"",
        assignmentNumber:0,
        courseID:0,
        description:"",
        dueDate:"",
        graded:false,
        possiblePoints:0,
        studentGrade:0,
        submission:"",
        submissionDateTime: "",
        submitted:false,
        submittedDateTime:"",
        teacherFeedback:""
      },
      submission: '',
      assignmentID: this.$route.params.assignmentID,
      courseID: this.$route.params.courseID,
      studentID: 0
    }
  },

  created() {
    this.getStudentIDAndAssignmentDetails();
  },

  methods: {
    getStudentIDAndAssignmentDetails() {
      courseService
        .getStudentID()
        .then(response => {
          // very, very hack way of doing this
          if (this.isTeacher) {
            this.studentID = this.$route.params.studentID;
          } else {
            this.studentID = response.data;
          }
          console.log(this.studentID);
          this.getAssignmentDetails(this.courseID, this.assignmentID, this.studentID);
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

    getAssignmentDetails(courseID, assignmentID, studentID) {
      courseService
        .getAssignmentDetails(courseID, assignmentID, studentID)
        .then(response => {
          this.assignment = response.data;
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

    submitAssignment(submission, assignmentID, courseID) {
      console.log("submitAssignment() called");
      courseService
        .submitAssignment(submission, assignmentID, courseID)
        .then(response => {
          if (response && response.status == 201) {
            this.assignment.submitted = true;
            this.getAssignmentDetails(this.courseID, this.assignmentID, this.studentID);
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

    gradeAssignment(assignment, assignmentID, courseID) {
      courseService
        .gradeAssignment(assignment, assignmentID, courseID)
        .then(response => {
          if (response && response.status == 201) {
            this.assignment.graded = true;
            this.getAssignmentDetails(this.courseID, this.assignmentID, this.studentID);
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

    resetSubmission() {
      this.assignment.submission = '';
    }
  }

}
</script>

<style>
.main-body {
      background-image: none;
      border: none;
    }
 
.i-frame, .i-frame > input {
  text-align: center;
  justify-content: center;
  align-items: center;
  margin-left: auto;
  margin-right: auto;
}

input {
  width: 100%;
}

</style>