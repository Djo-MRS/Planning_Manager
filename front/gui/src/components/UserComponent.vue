<template>
  <div class="user">
    <MDBContainer>
      <MDBRow>
        <MDBCol>
          <h2>Create a userr</h2>
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
            ">
            <option disabled value="">Select a user</option>
            <option v-for="user in users" :key="user.id" :value="user.id">
              {{ user.username }}
            </option>
          </select>
        </MDBCol>
      </MDBRow>
      <MDBRow>
        <MDBCol>
          <h2>Update user</h2>
          <div class="text-center mb-3">
            <form @submit.prevent="updateUser">
              <MDBInput 
                label="Username"
                v-model="username"
                required
                class="mb-3"
              />
              <MDBInput
                label="Email" 
                type="email"
                v-model="email" 
                required
                class="mb-3"
              />
              <MDBBtn type="submit" class="
                btn btn-primary
                btn-block
                mb-4">Update</MDBBtn>
            </form>
            <div v-if="messageUpdated" class="mt-3">{{ messageUpdated }}</div>
          </div>
        </MDBCol>
        <MDBCol>
          <h2>Delete user</h2>
          <div class="text-center mb-3">
            <form @submit.prevent="deleteUser">
              <MDBInput
                label="Username"
                v-model="username"
                disabled
                class="mb-3"
              />
              <MDBInput
                label="Email" 
                type="email"
                v-model="email" 
                disabled
                class="mb-3"
              />
              <MDBBtn type="submit" class="
                btn btn-danger
                btn-block
                mb-4">Delete</MDBBtn>
            </form>
            <div v-if="messageDeleted" class="mt-3">{{ messageDeleted }}</div>
          </div>
        </MDBCol>
      </MDBRow>
      <MDBIcon icon="camera-retro" size="10x" />
    </MDBContainer>
  </div>
</template>

<script>
import { MDBBtn, MDBContainer, MDBInput, MDBRow, MDBCol, MDBIcon } from "mdb-vue-ui-kit";

export default {
  name: "UserComponent",
  components: {
    MDBContainer,
    MDBInput,
    MDBBtn,
    MDBCol,
    MDBRow,
    MDBIcon
  },
  data() {
    return {
      username: "",
      email: "",
      users: [],
      selectedUserId: "",
      message: "",
      messageUpdated: "",
      messageDeleted: "",
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

        if (response.ok) {
          this.message = "User created successfully!";
          this.createUsername = "";
          this.createEmail = "";
          this.messageDeleted = "";
          this.messageUpdated = "";
          await this.getUsers(); // Refresh user list
        } else {
          this.message = "Error creating user: " + response.statusText;
        }
      } catch (error) {
        this.message = "Error creating user: " + error.message;
      }
    },
    async updateUser() {
      try {
        const response = await fetch("http://localhost:4000/api/users/" + this.selectedUserId, {
          method: "PUT",
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

        if (response.ok) {
          this.messageUpdated = "User updated successfully!";
          this.messageDeleted = "";
          this.message = "";
          await this.getUsers(); // Refresh user list
        } else {
          this.messageUpdated = "Error updating user: " + response.statusText;
        }
      } catch (error) {
        this.messageUpdated = "Error updating user: " + error.message;
      }
    },
    async deleteUser() {
      try {
        const response = await fetch("http://localhost:4000/api/users/" + this.selectedUserId, {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json"
          }
        });

        if (response.status === 204) {
          this.messageDeleted = "User deleted successfully!";
          this.messageUpdated = "";
          this.message = "";
          this.email = "";
          this.username = "";
          await this.getUsers(); // Refresh user list
        } else {
          this.messageDeleted = "Error deleting user: " + response.statusText;
        }
      } catch (error) {
        this.messageDeleted = "Error deleting user: " + error.message;
      }
    }
  }
};
</script>


<style scoped>
/* Add any specific styles for your component here */
</style>
