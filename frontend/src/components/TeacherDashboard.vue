<template>
  <div>
    <h2>Teacher Dashboard</h2>
    <br>
    <h3>My Courses:</h3>
    <div v-for="course in myCoursesToTeach" v-bind:key="course.courseID">
      <div>
        <h4>{{course.title}}</h4>
        <!-- <h5>You have {{notifications(course.courseID)}} ungraded assignments</h5> -->
        
        <!-- <div v-for="assignment in ungradedAssignments" v-bind:key="assignment.uniqueID">
          <router-link v-bind:to="{ name: 'assignment-teacher', params: { courseID: assignment.courseID, assignmentID : assignment.assignmentID, studentID : assignment.studentID } }">
            {{assignment.studentID}} {{assignment.assignmentName}} {{assignment.assignmentNumber}}
          </router-link>
        </div> -->

        <router-link v-bind:to="{ name: 'course-details', params: { courseID: course.courseID } }">
          Lessons and Assignments
        </router-link>
        <br>
        <br>
      </div>
      <div>
        <router-link v-bind:to="{ name: 'progress', params: { courseID: course.courseID } }">
          Students' Progress
        </router-link>
        <br>
        <br>
      </div>
      <br>
      <br>
    </div>
    
  </div>
</template>

<script>
import courseService from '../services/CourseService';
export default {
    name: 'teacher-dashboard',

    data() {
      return {
        myCoursesToTeach: [],
        assignments: [],
        ungradedAssignments: []
      }
    },

    created() {
      this.getMyCoursesToTeach();
    },

    methods: {
      getMyCoursesToTeach() {
        courseService
          .getMyCoursesToTeach()
          .then(response => {
            this.myCoursesToTeach = response.data;
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

      getAssignmentsForCourse(courseID) {
        courseService
          .getAssignmentsForCourse(courseID)
          .then(response => {
              this.assignments = [];
              this.assignments = response.data;
              let counter = 1;
              for (let entry of this.assignments) {
                  entry.uniqueID = counter;
                  counter++;
              }
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

    notifications(courseID) {
      // this.ungradedAssignments = [];
      this.getAssignmentsForCourse(courseID);
      let counter = 0;
      for(let assignment of this.assignments) {
        if (assignment.submitted && !assignment.graded) {
          counter++;
          // this.ungradedAssignments.push(assignment);
        }
      }
      return counter;
    }
  }
}
</script>

<style>
.card-details {
background-image: linear-gradient(to bottom right, rgba(0, 0, 0, 0.315), rgb(68, 68, 68));
border-style: solid;
border-width: 1px;
border-radius: 8px;
box-shadow: 0px 0px 100px rgba(8, 8, 8, 0.144);
margin-top: 15px;
padding-top: 1.5%;
padding-bottom: 0%;
padding-left: 10px;
padding-bottom: auto;
font-family: sans-serif;
}

.card-details:hover {
font-size: 101%;
}


.course-title {
font-weight: bold;

}

.add-course-btn {
margin: 15px;
}

.teacher-notifications {
  display: block;
  text-align: right;
}
</style>