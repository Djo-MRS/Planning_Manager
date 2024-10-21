<template>
  <div class="signup-container">
    <img src="@/assets/logohometimemanager.jpg" alt="Logo" class="logo" />
    <form @submit.prevent="signUp" class="signup-form">
      <input
        type="text"
        v-model="name"
        placeholder="Name"
        required
        class="input-field"
      />
      <input
        type="text"
        v-model="firstname"
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
        required
        class="input-field"
      />
      <input
        type="password"
        v-model="confirmPassword"
        placeholder="Confirm Password"
        required
        class="input-field"
      />
      <button type="submit" class="sign-up-button">Inscription</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      name: '',
      firstname: '',
      email: '',
      phone: '',
      password: '',
      confirmPassword: '',
    };
  },
  methods: {
    async signUp() {
      if (this.password !== this.confirmPassword) {
        alert('Les mots de passe ne correspondent pas.');
        return;
      }

      try {
        await axios.post('/api/users/sign_up', {
          name: this.name,
          firstname: this.firstname,
          email: this.email,
          phone: this.phone,
          password: this.password,
        });
        this.$router.push('/');
      } catch (error) {
        console.error('Error signing up:', error);
      }
    },
  },
};
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

  