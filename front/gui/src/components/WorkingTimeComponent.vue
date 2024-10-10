<template>
    <main>
      <RouterView />
      <MDBContainer>
      <MDBRow>
        <MDBCol>
          <h2>Select a user</h2>
          <select
            v-model="selectedUserId"
            @change="selectUser"
            class="
              form-select
              form-select-lg
              mb-3
              mt-3
              col-6
            "
          >
            <option disabled value="">Select a user</option>
            <option v-for="user in users" :key="user.id" :value="user.id">
              {{ user.username }}
            </option>
          </select>
        </MDBCol>
      </MDBRow>
    </MDBContainer>
    </main>
  </template>
  
  <script>
  import { MDBContainer, MDBCol } from "mdb-vue-ui-kit";

  export default {
  name: "UserComponent",
  components: {
    MDBContainer,
    MDBCol,
 
  },
  data() {
    return {
      username: "",
      email: "",
      users: [],
      selectedUserId: "",  // This will hold the selected user ID
      message: "",
      createUsername: "",
      createEmail: ""
    };
  },
  mounted() {
    this.getUsers();
  },
  methods: {
    async getUsers() {
      try {
        const response = await fetch("http://localhost:4000/api/users");
        this.users = (await response.json()).data;
      } catch (error) {
        this.message = "Error getting users: " + error.message;
      }
    },
    selectUser() {
      const selectedUser = this.users.find(user => user.id === this.selectedUserId);
      if (selectedUser) {
        this.username = selectedUser.username;
        this.email = selectedUser.email;
      } else {
        this.username = "";
        this.email = "";
      }
    }
  }
}
  </script>
  
  <style>
  #app {
    font-family: Roboto, Helvetica, Arial, sans-serif;
  }
  </style>

