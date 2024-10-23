<template>
  <div class="signup-container">
    <img src="@/assets/logohometimemanager.jpg" alt="Logo" class="logo" />
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
      <button type="submit" class="sign-up-button">Inscription</button>
    </form>
  </div>
</template>

<script>

export default {
  data() {
    return {
      lastname: '',
      firstname: '',
      email: '',
      password: '',
      confirmPassword: '',
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

        if (response.ok) {
     //     this.message = "User created successfully!";
          this.username = "";
          this.email = "";
        // this.messageDeleted = "";
        //  this.messageUpdated = ""; -->
      //    await this.getUsers(); // Refresh user list
        } else {
      //    this.message = "Error creating user: " + response.statusText;
        }
      } catch (error) {
     //   this.message = "Error creating user: " + error.message;
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

.sign-up-button {
  padding: 10px;
  background-color: #007bff; 
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.sign-up-button:hover {
  background-color: #0056b3; 
}
</style>

  