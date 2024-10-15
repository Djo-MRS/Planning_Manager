<template>
  <div class="clocking p-6 max-w-lg mx-auto bg-white rounded-xl shadow-md space-y-4">
    <h3 class="text-xl font-bold text-center text-gray-700 mb-4">Pointage</h3>
    <div>
      <label for="userSelect" class="block text-sm font-medium text-gray-700 mb-2">Sélectionner un utilisateur :</label>
      <select 
        id="userSelect" 
        v-model="selectedUserId" 
        @change="selectUser" 
        class="block w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500"
      >
        <option value="" disabled selected>Choisissez un utilisateur...</option>
        <option v-for="user in users" :key="user.id" :value="user.id">{{ user.username }}</option>
      </select>
    </div>
    <div v-if="errorMessage" class="bg-red-100 text-red-700 p-4 rounded-md">
      <p>{{ errorMessage }}</p>
    </div>
    <div v-else-if="selectedUserId" class="mt-4 text-center">
      <div v-if="lastAction === 'clockIn'" class="space-y-3">
        <p class="text-lg font-semibold text-green-600">Actuellement pointé depuis : {{ formattedStartDateTime }}</p>
        <span @click="clockOut" class="clock-icon cursor-pointer hover:text-red-600">
          <MDBIcon icon="clock" />   
        </span>
      </div>
      <div v-else-if="lastAction === 'clockOut'" class="space-y-3">
        <p class="text-lg font-semibold text-gray-600">Actuellement dépointé depuis : {{ formattedStartDateTime }}</p>
        <span @click="clockInUser" class="clock-icon cursor-pointer hover:text-blue-600">
          <MDBIcon icon="clock" />  
         </span>
      </div>
      <div v-else class="space-y-3">
        <p class="text-lg font-semibold text-gray-600">Vous n'êtes pas pointé.</p>
        <span @click="clockInUser" class="clock-icon cursor-pointer hover:text-blue-600">
          <MDBIcon icon="clock" />        
        </span>
      </div>
    </div>
  </div>
</template>




<script>
import { MDBIcon } from 'mdb-vue-ui-kit';

export default {
  name: "ClockingComponent",
  components: {
    MDBIcon
  },
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
  max-width: 400px;
  padding: 20px;
  background-color: #f9fafb;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.clock-icon {
  font-size: 36px; /* Agrandir les icônes */
  color: inherit; /* Garde la couleur courante */
  transition: color 0.3s ease, transform 0.2s;
}

.clock-icon:hover {
  transform: scale(1.2); /* Augmentation légère de la taille au survol */
}
</style>

