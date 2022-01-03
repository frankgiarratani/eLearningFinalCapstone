<template>
  <course-details v-bind:isTeacher="this.$store.state.isTeacher"></course-details>
</template>

<script>
import CourseDetails from '../components/CourseDetails.vue'

export default {
    components: {
        CourseDetails
    }
}
</script>

<style>

</style>