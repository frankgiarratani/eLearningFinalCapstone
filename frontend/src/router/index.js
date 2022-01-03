import Vue from 'vue'
import VueYoutube from 'vue-youtube'
import VueGoogleApi from 'vue-google-api'
import Router from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import Register from '../views/Register.vue'
import store from '../store/index'

import CourseList from '../views/CourseList.vue'
import CourseDetailsView from '../views/CourseDetailsView.vue'
import AssignmentView from '../views/AssignmentView.vue'
import LessonView from '../views/LessonView.vue'
import StudentsProgressView from '../views/StudentsProgressView.vue'

// FOR YOUTUBE API **************
Vue.use(VueYoutube)
Vue.config.productionTip = false
// FOR YOUTUBE API **************

// FOR GOOGLE API ***************
const config = {
  apiKey: 'AIzaSyBVwOFcU9w6wqDp6AjQffvXq8WaIAKk4M0',
  clientId: 'your_client_id.apps.googleusercontent.com',
  scope: 'space_separated_scopes',
  discoveryDocs: []
}
Vue.use(VueGoogleApi, config)
// FOR GOOGLE API ***************

Vue.use(Router)

/**
 * The Vue Router is used to "direct" the browser to render a specific view component
 * inside of App.vue depending on the URL.
 *
 * It also is used to detect whether or not a route requires the user to have first authenticated.
 * If the user has not yet authenticated (and needs to) they are redirected to /login
 * If they have (or don't need to) they're allowed to go about their way.
 */

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/logout",
      name: "logout",
      component: Logout,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/register",
      name: "register",
      component: Register,
      meta: {
        requiresAuth: false
      }
    },

    // all routes above this line were here from starter code, below this line has been created
    
    {
      path: '/courseList',
      name: 'course-list',
      component: CourseList,
      meta: {
        requiresAuth: false
      }
    },

    {
      path: '/course/:courseID',
      name: 'course-details',
      component: CourseDetailsView
    },

    {
      path: '/course/:courseID/assignments/:assignmentID/students/:studentID',
      name: 'assignment-teacher',
      component: AssignmentView
    },

    {
      path: '/course/:courseID/assignments/:assignmentID',
      name: 'assignment-student',
      component: AssignmentView
    },

    {
      path: '/course/:courseID/lessons/:lessonID',
      name: 'lesson',
      component: LessonView
    },

    {
      path: '/teacherView/course/:courseID',
      name: 'progress',
      component: StudentsProgressView
    },

  ]
});

router.beforeEach((to, from, next) => {
  // Determine if the route requires Authentication
  const requiresAuth = to.matched.some(x => x.meta.requiresAuth);

  // If it does and they are not logged in, send the user to "/login"
  if (requiresAuth && store.state.token === '') {
    next("/login");
  } else {
    // Else let them go to their next destination
    next();
  }
});

export default router;
