<template>
  <div class="home">
    <br>
    <router-link v-bind:to="{ name: 'course-list'}">
      Go to course catalog
    </router-link>

    <br>

    <student-dashboard v-show="!isTeacher"></student-dashboard>

    <teacher-dashboard v-show="isTeacher"></teacher-dashboard>
    
  </div>
</template>

<script>
import StudentDashboard from '../components/StudentDashboard.vue';
import TeacherDashboard from '../components/TeacherDashboard.vue';

export default {
  name: "home",
  props: ['isTeacher'],

  components: {
    StudentDashboard,
    TeacherDashboard
  },

  // data() {
  //   return {
  //       userIsTeacher: false
  //   }
  // }

};
</script>
