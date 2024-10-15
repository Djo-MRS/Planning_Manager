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
      <div v-if="lastAction === 'clockIn'">
        <p>Actuellement pointé depuis : {{ formattedStartDateTime }}</p>
        <button @click="clockOut">Dépointer</button>
      </div>
      <div v-else-if="lastAction === 'clockOut'">
        <p>Actuellement dépointé depuis : {{ formattedStartDateTime }}</p>
        <button @click="clockInUser">Pointer</button>
      </div>
      <!-- Affichage si l'utilisateur est dépointé ou n'a jamais pointé -->
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
      users: [],
      selectedUserId: "",
      clockIn: false,
      startDateTime: null,
      formattedStartDateTime: "",
      errorMessage: "",
      lastAction: null, 
    };
  },
  mounted() {
    this.getUsers();
  },
  methods: {
    async getUsers() {
      try {
        const response = await fetch("http://localhost:4000/api/users");
        if (!response.ok) {
          throw new Error("Erreur lors de la récupération des utilisateurs");
        }
        const result = await response.json();
        this.users = result.data;
      } catch (error) {
        this.errorMessage =
          "Erreur lors de la récupération des utilisateurs : " + error.message;
      }
    },

    async selectUser() {
      if (this.selectedUserId) {
        await this.fetchClockStatus();
      } else {
        // Réinitialiser les états si aucun utilisateur n'est sélectionné
        this.clockIn = false;
        this.lastAction = null;
        this.startDateTime = null;
        this.formattedStartDateTime = "";
        this.errorMessage = "";
      }
    },

    async fetchClockStatus() {
      // Réinitialiser le message d'erreur au début
      this.errorMessage = "";
      try {
        const response = await fetch(
          `http://localhost:4000/api/clocks/${this.selectedUserId}`
        );
        if (!response.ok) {
          if (response.status === 404) {
            // Aucun pointage trouvé, réinitialiser les états
            this.clockIn = false;
            this.lastAction = null;
            this.startDateTime = null;
            this.formattedStartDateTime = "";
            return; // Sortir de la méthode sans définir d'erreur
          } else {
            throw new Error("Erreur lors de la récupération de l'état de pointage");
          }
        }

        const result = await response.json();
        const data = result.data;

        if (Array.isArray(data) && data.length > 0) {
          const lastClock = data
            .sort((a, b) => new Date(b.time) - new Date(a.time))[0];

          if (lastClock) {
            this.clockIn = lastClock.status;
            this.startDateTime = lastClock.time;
            this.formattedStartDateTime = new Date(this.startDateTime).toLocaleString("fr-FR");
            this.lastAction = lastClock.status ? "clockIn" : "clockOut"; 
          } else {
            this.clockIn = false;
            this.lastAction = null;
          }
        } else {
          // Si les données sont vides ou non valides, réinitialiser les états
          this.clockIn = false;
          this.lastAction = null;
          this.startDateTime = null;
          this.formattedStartDateTime = "";
        }
      } catch (error) {
        console.error(
          "Erreur lors de la récupération de l'état de pointage",
          error
        );
        this.errorMessage = `Erreur : ${error.message}`;
      }
    },

    async clockInUser() {
      try {
        const response = await fetch(
          `http://localhost:4000/api/clocks/${this.selectedUserId}`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              clock: {
                clockIn: true,
                time: new Date().toISOString(),
              },
            }),
          }
        );
        if (!response.ok) {
          throw new Error("Erreur lors du pointage");
        }
        await response.json();
        this.clockIn = true;
        this.startDateTime = new Date().toISOString();
        this.formattedStartDateTime = new Date().toLocaleString("fr-FR");
        this.lastAction = "clockIn";
        this.errorMessage = "";
      } catch (error) {
        this.errorMessage = `Erreur : ${error.message}`;
      }
    },

    async clockOut() {
      try {
        const response = await fetch(
          `http://localhost:4000/api/clocks/${this.selectedUserId}`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              clock: {
                clockIn: false,
                time: new Date().toISOString(),
              },
            }),
          }
        );
        if (!response.ok) {
          throw new Error("Erreur lors du dépointage");
        }
        await response.json();
        this.clockIn = false;
        this.lastAction = "clockOut"; 
        this.startDateTime = new Date().toISOString();
        this.formattedStartDateTime = new Date().toLocaleString("fr-FR");
        this.errorMessage = "";
      } catch (error) {
        this.errorMessage = `Erreur : ${error.message}`;
      }
    },

    refresh() {
      if (this.selectedUserId) {
        this.fetchClockStatus();
      }
    },
  },
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
