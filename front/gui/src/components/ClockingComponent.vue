<template>
  <div class="clocking">
    <h3>Clocking</h3>
    <div>
      <label for="userSelect">Sélectionner un utilisateur :</label>
      <select id="userSelect" v-model="selectedUserId" @change="selectUser">
        <option value="" disabled selected></option>
        <option v-for="user in users" :key="user.id" :value="user.id">{{ user.username }}</option>
      </select>
    </div>
    <div v-if="errorMessage">
      <p>{{ errorMessage }}</p>
    </div>
    <div v-else-if="selectedUserId">
      <div v-if="clockIn">
        <p>Actuellement pointé depuis : {{ formattedStartDateTime }}</p>
        <button @click="clockOut">Dépointer</button>
      </div>
      <div v-else>
        <p>Vous n'êtes pas pointé.</p>
        <button @click="clockInUser">Pointer</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "ClockingComponent",
  data() {
    return {
      username: "",
      email: "",
      users: [],
      selectedUserId: "",
      clockIn: false,
      startDateTime: null,
      formattedStartDateTime: '',
      errorMessage: ''
    };
  },
  mounted() {
    this.getUsers();
    setInterval(() => {
      this.refresh(); // Mise à jour toutes les 5 secondes
    }, 5000); // Intervalle de 5 secondes
  },
  methods: {
    async getUsers() {
      try {
        const response = await fetch("http://localhost:4000/api/users");
        this.users = (await response.json()).data;
      } catch (error) {
        this.errorMessage = "Erreur lors de la récupération des utilisateurs : " + error.message;
      }
    },
    selectUser() {
      const selectedUser = this.users.find(user => user.id === this.selectedUserId);
      if (selectedUser) {
        this.errorMessage = '';
        this.fetchClockStatus();
      } else {
        this.errorMessage = "Erreur : Utilisateur non trouvé";
        this.clockIn = false;
        this.startDateTime = null;
        this.formattedStartDateTime = '';
      }
    },
    async fetchClockStatus() {
      try {
        const response = await fetch(`http://localhost:4000/api/clocks/${this.selectedUserId}`, {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
          }
        });
        if (!response.ok) {
          if (response.status === 404) {
            throw new Error("Utilisateur non trouvé");
          } else {
            throw new Error("Erreur de serveur");
          }
        }
        const data = await response.json();
        if (data && data.clockIn) {
          this.clockIn = true;
          this.startDateTime = data.startDateTime;
          this.formattedStartDateTime = new Date(data.startDateTime).toLocaleString('fr-FR');
        } else {
          this.clockIn = false;
        }
      } catch (error) {
        console.error("Error fetching clock status", error);
        this.errorMessage = `Erreur : ${error.message}`;
      }
    },
    async clockInUser() {
      try {
        const response = await fetch(`http://localhost:4000/api/clocks/${this.selectedUserId}`, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            clock: {
              clockIn: true,
              time: new Date().toISOString()
            }
          })
        });
        if (!response.ok) {
          if (response.status === 404) {
            throw new Error("Utilisateur non trouvé");
          } else {
            throw new Error("Erreur de serveur");
          }
        }
        await response.json();
        this.clockIn = true;
        this.startDateTime = new Date().toISOString();
        this.formattedStartDateTime = new Date().toLocaleString('fr-FR');
        this.errorMessage = '';
      } catch (error) {
        console.error("Error clocking in", error);
        this.errorMessage = `Erreur : ${error.message}`;
      }
    },
    async clockOut() {
      try {
        const response = await fetch(`http://localhost:4000/api/clocks/${this.selectedUserId}`, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            clock: {
              user_id: this.selectedUserId,
              clockIn: false,
              time: new Date().toISOString()
            }
          })
        });
        if (!response.ok) {
          if (response.status === 404) {
            throw new Error("Utilisateur non trouvé");
          } else {
            throw new Error("Erreur de serveur");
          }
        }
        await response.json();
        this.clockIn = false;
        this.startDateTime = null;
        this.errorMessage = '';
      } catch (error) {
        console.error("Error clocking out", error);
        this.errorMessage = `Erreur : ${error.message}`;
      }
    },
    refresh() {
      if (this.selectedUserId) {
        this.fetchClockStatus();
      }
    },
    clock() {
      if (this.clockIn) {
        this.clockOut();
      } else {
        this.clockInUser();
      }
    }
  }
};
</script>

<style scoped>
.clocking {
  margin: 20px;
}
button {
  padding: 10px;
  margin-top: 10px;
}
</style>