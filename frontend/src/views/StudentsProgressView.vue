<template>
  <div class="margin">
  <students-progress></students-progress>
  </div>
</template>

<script>
import StudentsProgress from '../components/StudentsProgress.vue';
export default {
    components: {
        StudentsProgress
    }
}
</script>

<style>

.margin {
  display: block;
  margin-left: auto;
  margin-top: 10px;
  margin-right: auto;
  padding-left: 10px;
  padding-right: 10px;
  background-image: linear-gradient(to bottom right, rgb(36, 36, 36), rgb(68, 68, 68));
  border-style: solid;
  border-width: 1px;
  border-radius: 5px;
  width: 65%;
}

</style>