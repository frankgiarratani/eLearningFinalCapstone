<template>
  <div id="register" class="text-center">
    
    <form class="form-register" @submit.prevent="register">
      <div class="fit-in-the-border">
        <h1 class="h3 mb-3 font-weight-normal">Create Account</h1>
        <div class="alert alert-danger" role="alert" v-if="registrationErrors">
          {{ registrationErrorMsg }}
        </div>
        <label for="firstName" class="sr-only">First name</label>
        <input
          type="text"
          id="firstName"
          class="form-control"
          placeholder="First name"
          v-model="user.firstName"
          required
          autofocus
        />
        <br>
        <label class="sr-only" for="lastName" >Last name</label>
        <input
          type="text"
          id="lastName"
          class="form-control"
          placeholder="LastName"
          v-model="user.lastName"
          required
          autofocus
        />

        <label for="username" class="sr-only">Username</label>
        <input
          type="text"
          id="username"
          class="form-control"
          placeholder="Username"
          v-model="user.username"
          required
          autofocus
        />
        <br>
        <label for="password" class="sr-only">Password</label>
        <input
          type="password"
          id="password"
          class="form-control"
          placeholder="Password"
          v-model="user.password"
          required
        />
        <br>
        <input
          type="password"
          id="confirmPassword"
          class="form-control"
          placeholder="Confirm Password"
          v-model="user.confirmPassword"
          required
        />
        <div class="am-a-teacher">
          <input class="am-a-teacher-checkbox" type="checkbox" id="isTeacher" v-model="user.isTeacher">
          <label class="am-a-teacher-label" for="isTeacher">I am registering as a teacher</label>
        </div>

        <br/>
        <button class="create-account-button" type="submit">Create Account</button>
        <br>
        <router-link class="have-account-btn" :to="{ name: 'login' }">Have an account?</router-link>
        
          
        
      </div>
    </form>
  </div>
</template>

<script>
import authService from '../services/AuthService';

export default {
  name: 'register',
  data() {
    return {
      user: {
        username: '',
        password: '',
        confirmPassword: '',
        firstName: '',
        lastName: '', 
        isTeacher: false,
        role: 'user'
      },
      registrationErrors: false,
      registrationErrorMsg: 'There were problems registering this user.',
    };
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = 'Password & Confirm Password do not match.';
      } else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {
              this.$router.push({
                path: '/login',
                query: { registration: 'success' },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = 'Bad Request: Validation Errors';
            }
          });
      }
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = 'There were problems registering this user.';
    },
  },
};
</script>

<style scoped>
.main-body {
      background-image: none;
      border: none;
    }
    
.form-register
{
  display: block;
	width: 40%;
	height: 75%;
	margin-left: auto;
  margin-right: auto;
  margin-top: 0px;
	background: rgb(49, 49, 49);
	padding: 15px;
  border-style: solid;
  border-width: 1px;
	border-radius: 8px;
  box-shadow: 0px 0px 100px rgba(219, 219, 219, 0.178);
  text-align: left;
  opacity: 0.7;
  color: rgb(221, 221, 197);
}

input {
  margin: 5px 0px 5px 0px;
}
input[type='text'], input[type='password'] {
  margin-left: auto;
  margin-right: auto;
  width: 98%;
}

input[type='checkbox'] {
  margin-left: 0px;
  text-align: left;
  display: inline-block;
  align-items: left;
}

.am-a-teacher {
  width: 100%;
  display: inline-block;
  align-items: left;
  padding-top: 5px;
  margin: 0px;
}

.am-a-teacher-checkbox {
  display: inline-block;
  padding-left: 0px;
  margin-left: 0px;
  height: 25px;
  width: 35px;
}

.am-a-teacher-label {
  padding-bottom: 2px;
}

.need-account-btn {
  color: rgb(221, 221, 197);
}

.fit-in-the-border {
  position: relative;
  height: 100%;
}

.create-account-button {
  margin-top: 5px;
  margin-bottom: 5px;
}

.have-account-btn {
  margin-top: 10px;
}
</style>
