<template>
  <div class="login-container">
    <img src="@/assets/logohometimemanager.jpg" alt="Logo" class="logo" /> 
    <form @submit.prevent="signIn" class="login-form">
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
      <button type="submit" class="sign-in-button">Se Connecter</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      email: '',
      password: '',
    };
  },
  methods: {
    async signIn() {
      try {
        const response = await axios.post('/api/sign_in', {
          email: this.email,
          password: this.password,
        });

        localStorage.setItem('xsrfToken', response.data.xsrfToken);
        localStorage.setItem('userId', response.data.userId);
        localStorage.setItem('roleId', response.data.roleId);

        this.$router.push('/');
      } catch (error) {
        console.error('Erreur de connexion:', error);
      }
    },
  },
};
</script>

<style scoped>
.login-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh; 
  background-color: #fff; 
}

.logo {
  max-width: 400px; /* Ajustez la taille de l'image */
  margin-bottom: 20px; /* Espace entre l'image et le formulaire */
}

.login-form {
  display: flex;
  flex-direction: column;
  width: 300px; /* Largeur du formulaire */
}

.input-field {
  padding: 10px;
  margin-bottom: 15px; /* Espace entre les champs */
  border: 1px solid #ccc;
  border-radius: 4px;
}

.sign-in-button {
  padding: 10px;
  background-color: #007bff; /* Couleur du bouton */
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.sign-in-button:hover {
  background-color: #0056b3; /* Couleur au survol */
}
</style>
