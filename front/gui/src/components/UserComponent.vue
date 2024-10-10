<template>
  <div class="user">
    <NavBarComponent />
    <MDBContainer>
      <div class="d-flex justify-content-start align-items-center flex-column">
        <h2>Create a user</h2>
        <div class="text-center mb-3">
          <form @submit.prevent="createUser">
             <MDBInput 
              label="Username" 
              v-model="username" 
              required
              class="mb-3"
            />
            <MDBInput
              label="Email" 
              v-model="email" 
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
      </div>
    </MDBContainer>
  </div>
</template>

<script>
import { MDBBtn, MDBContainer, MDBInput } from "mdb-vue-ui-kit";
import NavBarComponent from "@/components/NavBarComponent.vue";


export default {
  name: "UserComponent",
  components: {
    MDBContainer,
    MDBInput,
    MDBBtn,
    NavBarComponent
  },
  data() {
    return {
      username: "",
      email: "",
      users: [],
      message: ""
    };
  },
  methods: {
    async createUser() {
  try {
    const response = await fetch("http://localhost:4000/api/users", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        user: {
          username: this.username,
          email: this.email
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
