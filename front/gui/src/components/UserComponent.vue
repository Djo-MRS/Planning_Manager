<template>
  <div class="user">
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
        <MDBCol>
          <h2>Create a user</h2>
          <div class="text-center mb-3">
            <form @submit.prevent="createUser">
              <MDBInput 
                label="Username"
                v-model="createUsername"
                required
                class="mb-3"
              />
              <MDBInput
                label="Email" 
                type="email"
                v-model="createEmail" 
                required
                class="mb-3"
              />
              <MDBBtn type="submit" class="
                btn btn-primary
                btn-block
                mb-4">Create user</MDBBtn>
            </form>
            <div v-if="message" class="mt-3">{{ message }}</div>
          </div>
        </MDBCol>
      </MDBRow>
      <MDBRow>
        <MDBCol>
          <h2>Selected user</h2>
          <div v-if="username || email">
            <p><strong>Username:</strong> {{ username }}</p>
            <p><strong>Email:</strong> {{ email }}</p>
          </div>
        </MDBCol>
      </MDBRow>
    </MDBContainer>
  </div>
</template>

<script>
import { MDBBtn, MDBContainer, MDBInput, MDBRow, MDBCol } from "mdb-vue-ui-kit";

export default {
  name: "UserComponent",
  components: {
    MDBContainer,
    MDBInput,
    MDBBtn,
    MDBCol,
    MDBRow
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
    },
    async createUser() {
      try {
        const response = await fetch("http://localhost:4000/api/users", {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            user: {
              username: this.createUsername,
              email: this.createEmail
            }
          })
        });

        const newUser = await response.json();
        this.users.push(newUser);
        this.message = "User created successfully!";
        this.username = "";
        this.email = "";
      } catch (error) {
        this.message = "Error creating user: " + error.message;
      }
    }
  }
};
</script>

<style scoped>
/* Add any specific styles for your component here */
</style>
