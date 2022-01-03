<template>
    <assignment-details v-bind:isTeacher="this.$store.state.isTeacher"></assignment-details>
</template>

<script>
import AssignmentDetails from '../components/AssignmentDetails.vue'

export default {
    components: {
        AssignmentDetails
    }
}
</script>

<style>

</style>