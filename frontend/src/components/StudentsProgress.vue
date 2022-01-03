<template>
    <div>
        <table>
            <h1>Students' Progress</h1>
            <h2>{{course.title}}</h2> 
        
            <div v-for="student in students" v-bind:key="student.student_id">  
                <h3>{{student.firstName}} {{student.lastName}}</h3>
                <progress id="file"  v-bind:value="completedAssignments(student.student_id)" v-bind:max="totalAssignments(student.student_id)"> 15% </progress>
                    <tr>
                        <th class="assignment-col">Assignment</th>
                        <th class="points-earned-col">Points Earned</th>
                        <th class= "submitted-col">Submitted</th>
                        <th class="graded-col">Graded</th>
                    </tr>
                <div v-for="assignment in assignments" v-bind:key="assignment.uniqueID">
                    <div v-if="assignment.studentID == student.student_id">
                
                    
                        <tr>
                            <td class="assignment-col">
                                <router-link v-bind:to="{ name: 'assignment-teacher', params: { courseID: assignment.courseID, assignmentID : assignment.assignmentID, studentID : student.student_id } }">
                                    {{assignment.assignmentName}}
                                </router-link>
                            </td>
                            <td class="points-earned-col">
                                {{assignment.studentGrade}} out of {{assignment.possiblePoints}}
                            </td>
                            <td class= "submitted-col">
                                {{assignment.submitted ? "Yes" : "No"}}
                            </td>
                            <td class="graded-col">
                                {{assignment.graded ? "Yes" : "No"}}
                            </td>
                        </tr>
                    </div>
                </div>
            </div>
      
          
        </table>
    </div>
  
</template>

<script>
import courseService from '../services/CourseService';

export default {
    name: 'students-progress',

    data() {
        return {
            students: [],
            assignments: [],
            courseID: this.$route.params.courseID,
            course: {}
        }
    },

    created() {
        this.getStudentsForCourse(this.courseID);
        this.getCourseInfo(this.courseID);
        this.getAssignmentsForCourse(this.courseID);
    },


    methods: {
        getStudentsForCourse(courseID) {
            courseService
                .getStudentsForCourse(courseID)
                .then(response => {
                    this.students = response.data;
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

        completedAssignments(studentID) {
            let counter = 0;
            for (let assignment of this.assignments) {
                if(assignment.studentID==studentID && assignment.submitted) {
                    counter++;
                }
            }
            return counter;
        },

        totalAssignments(studentID) {
                 let counter = 0;
            for (let assignment of this.assignments) {
                if(assignment.studentID==studentID) {
                    counter++;
                }
            }
            return counter;
        },

        getCourseInfo(courseID) {
            courseService
                .getCourseInfo(courseID)
                .then(response => {
                    this.course = response.data;
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
        }
    }
}
</script>

<style>
    h1 {
        margin-bottom: 50px;
    }
    table {
        border-collapse: collapse;
        text-align: left;
        margin-left: auto;
        margin-right: auto;
    }

    td {
        border:1px solid red
    }
    .assignment-col {
        width: 500px;
    }

    .points-earned-col {
        width: 110px;
    }
    .submitted-col {
        width: 83px;
    }
    .graded-col {
        width: 60px;
    }
    th, td {
        border: solid rgb(90, 90, 90) 1px;
    }

    td {
        font-size: 15px;
    }

    .assignment-link {
        color: rgb(99, 135, 252);
        text-decoration: none;
    }

    .assignment-link:visited {
        color: rgb(159, 181, 255);
    }
</style>