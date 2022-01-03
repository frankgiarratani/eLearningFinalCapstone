<template>
    <div>
        <lesson-details v-bind:isTeacher="this.$store.state.isTeacher"></lesson-details>
        <br>
        
    </div>
</template>

<script>
import LessonDetails from '../components/LessonDetails.vue';

export default {
    components: {
        LessonDetails
    }
}
</script>

<style>
input {
background-color: rgb(68, 68, 68);
color: white;
border-radius: 3px;
border-width: 1px;
border-color: rgb(221, 221, 197);
height: 23px;
}

::placeholder {
color: rgb(161, 161, 157);
}

</style>