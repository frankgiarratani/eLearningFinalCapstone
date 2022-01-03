<template>
  <div class="main-div">
    <!-- Teacher Youtube Video Link Submission -->
    <div class="forms-div" v-show="isTeacher">
      <form class="youtube-url-form" v-on:submit="setVideoAndGoogleLessonForID(courseID, lessonID, lesson)">
        <p>Please paste the youtube video URL link for this lesson's content below:</p>
        <input  class="vid-url-input" v-model="lesson.youtubeURL" type="text" placeholder="Lesson Video URL" />
        <br>
        <p>Please paste the Google Doc URL link for this lesson's content below:</p>
        <input class="doc-url-input" v-model="lesson.lessonURL1" type="url" placeholder="Google Doc URL"/>
        <br>
        <p>Please paste the Google Doc URL link additional content below:</p>
        <input class="doc-url-input" v-model="lesson.lessonURL2" type="url" placeholder="Google Doc URL"/>
        <br>
        <p>Please enter in a description for the video content of this lesson below:</p>
        <textarea class="vid-description" v-model="lesson.youtubeText" placeholder="Video Description..."/>
                <button class="youtube-save-btn" type="submit" >Save</button>
      </form>
    </div>
    <br>
    <!-- Youtube Video & Google Doc Embedd -->
    <div class="youtube-video-player">
    <youtube v-bind:video-id="videoId" ref="youtube"  @playing="playing"></youtube>
    </div>
    <iframe width = 950px height = 1080px v-bind:src="lessonURL1"></iframe>
    <h2>Additional Resources</h2>
    <!-- Student Clickable Link for Google Doc -->
    <p>Click the link below for additional resources for this lesson.</p>
    <a href="https://docs.google.com/document/d/1ZGLwgDGd6vg-GssCPe0d7TQDO6wJ0uAruhNiANNiG3s/edit">Lesson Text</a>
  </div>
</template>
<script>
import Vue from 'vue'
import VueYoutube from 'vue-youtube'
import courseService from '../services/CourseService';
Vue.use(VueYoutube)
export default {
  name: 'lesson-details',
  props: ['isTeacher'],
  data() {
    return {
        lesson: {
          courseID: this.$route.params.courseID,
          lessonID: 0,
          lessonNumber: 0,
          lessonName: "",
          description: "",
          youtubeURL: "",
          youtubeText: "",
          lessonURL1: "",
          lessonURL2: "",
        },
        courseID: this.$route.params.courseID,
        lessonID: this.$route.params.lessonID,
        videoId: ''
    }
  },
  created() {
    this.getLessonDetails(this.courseID, this.lessonID);
  },
  methods: {
    // These two methods are required for the YouTube API to work with Vue
    playVideo() {
      this.player.playVideo()
    },
    // resetURL() {
    //   this.lesson.youtubeURL = ""
    // },
    playing() {
      console.log('o/ we are watching!!!')
    },
    getLessonDetails(courseID, lessonID) {
      courseService
        .getLessonDetails(courseID, lessonID)
        .then(response => {
          this.lesson = response.data;
          this.videoId = this.lesson.youtubeURL;
          this.lessonURL1 = this.lesson.lessonURL1;
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
    setVideoAndGoogleLessonForID(lessonID, courseID, lesson) {
      courseService
          .setVideoAndGoogleLessonForID(lessonID, courseID, lesson)
          .then(response => {
            if(response && response.status == 201) {
              this.lesson = response.data;
            // this.retrieveCourses();
            // this.resetForm();
            this.getLessonDetails(this.courseID, this.lessonID)
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
  //   updateLessonDoc(courseID, lessonID) {
  //     courseService
  //         .updateLessonDoc(courseID, lessonID)
  //         .then(response => {
  //           if(response && response.status == 201) {
  //           // this.retrieveCourses();
  //           // this.resetForm();
  //         }
  //       })
  //       .catch(error => {
  //         // log the error
  //         if (error.response) {
  //           this.errorMsg = "Error submitting new course. Response received was '" + error.response.statusText + "'.";
  //         } else if (error.request) {
  //           this.errorMsg = "Error submitting new course. Server could not be reached.";
  //         } else {
  //           this.errorMsg = "Error submitting new course. Request could not be created.";
  //         }
  //       });
  //   },
  //   updateVidDescription(courseID, lessonID) {
  //     courseService
  //         .updateVidDescription(courseID, lessonID)
  //         .then(response => {
  //           if(response && response.status == 201) {
  //           // this.retrieveCourses();
  //           // this.resetForm();
  //         }
  //       })
  //       .catch(error => {
  //         // log the error
  //         if (error.response) {
  //           this.errorMsg = "Error submitting new course. Response received was '" + error.response.statusText + "'.";
  //         } else if (error.request) {
  //           this.errorMsg = "Error submitting new course. Server could not be reached.";
  //         } else {
  //           this.errorMsg = "Error submitting new course. Request could not be created.";
  //         }
  //       });
  //   }
  // },
  },
  computed: {
    // This computed property is required for the YouTube API to work in Vue
    player () {
      return this.$refs.youtube.player
    },
    // mutations: {
    // getVideoID() {
    //     let index = this.lesson.youtubeURL.indexOf('v=');
    //     this.lesson.videoId = this.lesson.youtubeURL.substr(index+2);
    //     return this.videoId;
    // // },
    // }
  },
}
</script>
<style>
.iframe.youtube-vid {
display: block;
margin-left: auto;
margin-right: auto;
margin-top: 10px;
text-align: center;
}
.main-div {
  text-align: center;
}
p {
margin-bottom: 5px;
}
.save-btn {
  display:inline-block;
  margin-top: 8px;
  margin-bottom: 8px;
  margin-left: 8px;
  width: 60px;
}
h1, h2 {
  text-decoration: underline;
}
.forms-div {
  background-image: linear-gradient(to bottom right, rgba(0, 0, 0, 0.315), rgb(68, 68, 68));
  border-style: solid;
  border-radius: 5px;
  border-width: 1px;
  border-color: rgb(221, 221, 197);
  width: 50%;
  margin-left: auto;
  margin-right: auto;
}
.forms-div > p {
display: block;
text-align: center;
margin-top: 20px;
margin-bottom: 20px;
margin-left: 20px;
margin-right: 20px;
}
.vid-url-input, .doc-url-input, .vid-description{
  display: block;
  margin-right: auto;
  margin-left: auto;
}
.forms-div, input {
  width: 80%;
}
.youtube-save-btn, .google-save-btn, .save-vid-description {
  display: block;
  margin-left: auto;
  margin-right: auto;
  margin-top: 10px;
  margin-bottom: 20px;
  width: 81%;
}
textarea {
  background-color: rgb(68, 68, 68);
  color: white;
  width: 80%;
  height: 100px;
  margin-bottom: 20px;
  border-radius: 3px;
  border-style: 1px;
  border-color: rgb(221, 221, 197);
  border-style: 1px;
  font-family: sans-serif;
}
.youtube-video-player {
  margin-bottom: 20px;
}
</style>