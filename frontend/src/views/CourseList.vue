<template>
  <course v-bind:isTeacher="this.$store.state.isTeacher"/>
</template>

<script>
import Course from '../components/Course';

export default {
    name: "course-list",
    components: {
        Course
    }
}
</script>

<style>


</style>