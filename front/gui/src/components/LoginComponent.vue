<template>
  <div class="login-container">
    <img src="@/assets/logohometimemanager.jpg" alt="Logo" class="logo" /> 
    <form @submit.prevent="loginUser" class="login-form">
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
export default {
  data() {
    return {
      email: '',
      password: '',
    };
  },
  methods: {
    async loginUser() {
      try {
        const response = await fetch("http://localhost:4000/api/users/sign_in", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            email: this.email,
            password: this.password,
          }),
        });

        if (response.ok) {
          const data = await response.json();
          localStorage.setItem('token', data.token);
          this.$router.push('/home');
        } else {
          console.error("Erreur de connexion:", response.statusText);
          alert("Erreur de connexion. Veuillez vérifier vos identifiants.");
        }
      } catch (error) {
        console.error("Erreur lors de la connexion:", error.message);
        alert("Une erreur est survenue. Veuillez réessayer.");
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
  max-width: 400px; 
  margin-bottom: 20px; 
}

.login-form {
  display: flex;
  flex-direction: column;
  width: 300px; 
}

.input-field {
  padding: 10px;
  margin-bottom: 15px; 
  border: 1px solid #ccc;
  border-radius: 4px;
}

.sign-in-button {
  padding: 10px;
  background-color: #007bff; 
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.sign-in-button:hover {
  background-color: #0056b3; 
}

</style>