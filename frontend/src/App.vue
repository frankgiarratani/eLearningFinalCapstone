<template>
  <div>

    <nav class="nav">
      <router-link class="logo" v-bind:to="{ name: 'home' }" v-if="$store.state.token != ''"><img src="./assets/Whiteboard.png" alt="White Board Logo" ></router-link>
      <router-link class="course-li-link" v-bind:to="{ name: 'course-list' }" v-if="$store.state.token != ''">View Course List</router-link>
      
      <span class="user">{{ $store.state.user.firstName }} {{ $store.state.user.lastName }}</span>
      <router-link class="logout-icon" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''" ><img src="./assets/logout-icon.png" alt="Logout Icon" ></router-link>
    </nav>
    <br>

    <router-view class="main-body" v-bind:isTeacher="this.$store.state.isTeacher"/>
  </div>
</template>

<style> 

/*****************************NAVBAR STYLING IS BELOW***************************/
.nav {
  display: flex;
  position: relative;
  width: 100%;
  margin-left: -0.8%;
  padding-left: 5px;
  padding-right: 2%;
  background-size: 105%;
  justify-content: center;
  align-items: center;
  transform: translateY(-13%);
  background-image: linear-gradient( rgb(44, 44, 44), rgb(29, 29, 29));
  padding-bottom: 1px;
}
.logo {
  margin-right: 8px;
  margin-top:6px;
  margin-left: 8px;
  padding-bottom: 0px;
}

.course-li-link {
  margin-left: 20px;
}

.user {
  margin-left: auto;
  margin-right: 10px;
}
/*****************************NAVBAR STYLING IS ABOVE***************************/

/******************GENERIC STYLING FOR ENTIRE WEBSITE IS BELOW******************/
.main-body {
  height: 98%;
  display: block;
  margin-left: auto;
  margin-top: 10px;
  padding-bottom: 25px;
  margin-right: auto;
  padding-left: 10px;
  padding-right: 10px;
  background-image: linear-gradient(to bottom right, rgb(36, 36, 36), rgb(68, 68, 68));
  border-style: solid;
  border-width: 1px;
  border-radius: 5px;
  width: 65%;
}
body {
  background: cadetblue;
  background-image: url('./assets/darkthemebg.jpg');
  background-position: center;
  background-size: 100%;
  color: rgb(221, 221, 197);
  font-family: sans-serif;
}

a {
  color: rgb(221, 221, 197);
}

a:visited {
color: rgb(172, 172, 152);
}

button {
  border-style: solid;
  border-width: 1px;
  border-radius: 3px;
  padding: 5px;
  background-color: rgb(43, 43, 43);
  color: rgb(221, 221, 197);
}

button:hover {
  border-style: solid;
  border-width: 1px;
  border-radius: 3px;
  padding: 6px;
  background-color: rgb(43, 43, 43);
  color: rgb(221, 221, 197);
}
/******************GENERIC STYLING FOR ENTIRE WEBSITE IS ABOVE******************/
</style>
