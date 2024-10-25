<template>
  <MDBRow>
    <MDBCol>
      <h2>Create a user</h2>
        <form @submit.prevent="createUser" class="signup-form">
        <input
            type="text"
            v-model="lastname"
            placeholder="Lastname"
            required
            class="input-field"
          />
          <input
            type="text"
            v-model= "firstname"
            placeholder="Firstname"
            required
            class="input-field"
          />

          <input
            type="email" 
            v-model="email"
            placeholder="Email"
            required
            class="input-field"
          />
          <select v-model="role_id" class="role">
              <option value="" disabled>Choisir un rôle</option>
              <option v-for="role in roles" :key="role.id" :value="role.id">
                {{ role.name }}
              </option>
          </select>
          <input
            type="password"
            v-model="password"
            placeholder="Password"
            class="input-field"
          />
          <input
            type="password"
            v-model="confirmPassword"
            placeholder="Confirm Password"
            class="input-field"
          />
          <button type="submit" class="sign-up-button">Create</button>
        </form>

        <div v-if="message" class="mt-3">{{ message }}</div>

    </MDBCol>

    <MDBCol>
      <h2>Delete a user</h2>
        <form @submit.prevent="deleteUser" class="signup-form">
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
          {{ user.firstname }} {{ user.lastname }}
        </option>
      </select>
      <button type="submit" class="delete-button">Delete</button>
    </form>

    <div v-if="messageDeleted" class="mt-3">{{ messageDeleted }}  </div>
    </MDBCol>
  </MDBRow>
</template>

<script>

import { MDBRow, MDBCol } from 'mdb-vue-ui-kit';

export default {
  components: {
    MDBRow,
    MDBCol,
  },
  data() {
    return {
      lastname: '',
      firstname: '',
      email: '',
      role_id: '',
      password: '',
      confirmPassword: '',
      message: '',
      users: [],
      selectedUserId: '',
      messageDeleted: '',
      roles: [
        { id: 1, name: 'Admin' },
        { id: 2, name: 'Manager' },
        { id: 3, name: 'Employée' }
      ]
    };
  },
  mounted() {
    this.getUsers();
  },
  methods: {
    selectUser() {
      const user = this.users.find(user => user.id === this.selectedUserId);
      this.username = user.username;
      this.email = user.email;
    },
    async createUser() {
      console.log(JSON.stringify({
            user: {
              firstname: this.firstname,
              lastname: this.lastname,
              password: this.password,
              role_id: this.role_id,
              email: this.email
            }
          }));
      const csrfToken = document.cookie.split("c-xsrf-token=")[1]?.split(";")[0];
      try {
        const response = await fetch("/api/users/sign_up", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-XSRF-TOKEN": csrfToken,
            "Authorization": "Bearer " + localStorage.getItem("token")
          },
          credentials: "include",
          body: JSON.stringify({
            user: {
              firstname: this.firstname,
              lastname: this.lastname,
              password: this.password,
              role_id: this.role_id,
              email: this.email
            }
          })
        });

        if (response.ok) {
         this.message = "User created successfully!";
          this.username = "";
          this.email = "";
          this.messageDeleted = "";
          this.messageUpdated = "";
        } else {
         this.message = "Error creating user: " + response.statusText;
        }
      } catch (error) {
       this.message = "Error creating user: " + error.message;
      }
    },
    async getUsers() {
      try {
        const response = await fetch("/api/users");
        this.users = (await response.json()).data;
      } catch (error) {
        this.message = "Error getting users: " + error.message;
      }
    },

    async deleteUser() {
      const csrfToken = document.cookie.split("c-xsrf-token=")[1]?.split(";")[0];
      try {
        const response = await fetch("/api/users/" + this.selectedUserId, {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + localStorage.getItem("token"),
            "X-XSRF-TOKEN": csrfToken
          },
          credentials: "include"
        });

        if (response.ok) {
          this.messageDeleted = "User deleted successfully!";
          this.message = "";
          this.messageUpdated = "";
          await this.getUsers();
        } else {
          this.messageDeleted = "Error deleting user: " + response.statusText;
        }
      } catch (error) {
        this.messageDeleted = "Error deleting user: " + error.message;
      }
    },
}
}
</script>

<style scoped>
.signup-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh; 
  background-color: #fff; 
}

.logo {
  max-width: 400px;
  margin-bottom: 10px; 
}

.signup-form {
  display: flex;
  flex-direction: column;
  width: 400px; 
}

.input-field {
  padding: 10px;
  margin-bottom: 15px; 
  border: 1px solid #ccc;
  border-radius: 4px;
}

.role {
  padding: 10px;
  margin-bottom: 15px; 
  border: 1px solid #ccc;
  border-radius: 4px;
}

.sign-up-button {
  padding: 10px;
  background-color: rgb(115, 115, 215); 
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.delete-button {
  padding: 10px;
  background-color: #de1414; 
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
</style>

  