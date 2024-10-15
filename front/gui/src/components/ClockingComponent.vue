<template>
  <div
    v-if="users.length"
    class="clocking p-6 max-w-lg mx-auto bg-white rounded-xl shadow-md space-y-4"
  >
    <div class="mb-4">
      <label
        for="userSelect"
        class="block text-sm font-medium text-gray-700 mb-2"
        >Sélectionner un utilisateur :</label
      >
      <select
        id="userSelect"
        v-model="selectedUserId"
        @change="selectUser"
        class="block w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500"
      >
        <option value="" disabled selected>Choisissez un utilisateur...</option>
        <option v-for="user in users" :key="user.id" :value="user.id">
          {{ user.username }}
        </option>
      </select>
    </div>
    <div v-if="selectedUserId" class="mt-4">
      <h3 class="text-xl font-bold text-center text-gray-700 mb-4">
        {{ currentDateTime }}
      </h3>
      <div class="flex justify-center mb-4">
        <button v-if="!clockIn" @click="clockInUser" class="btn btn-primary">
          Badger en entrée
        </button>
        <button v-else @click="clockOut" class="btn btn-primary">
          Badger en sortie
        </button>
      </div>
      <div class="flex justify-between px-4">
        <p class="text-md font-medium text-gray-700">
          Commencé à : <span>{{ formattedStartTime || "--" }}</span>
        </p>
        <p class="text-md font-medium text-gray-700">
          Fini à : <span>{{ formattedEndTime || "--" }}</span>
        </p>
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
      formattedStartTime: "",
      formattedEndTime: "",
      errorMessage: "",
      lastAction: null,
      currentDateTime: new Date().toLocaleString("fr-FR", {
        weekday: "long",
        year: "numeric",
        month: "long",
        day: "numeric",
        hour: "2-digit",
        minute: "2-digit",
        second: "2-digit",
      }),
    };
  },
  mounted() {
    this.getUsers();
    this.updateCurrentDateTime();
    if (this.selectedUserId) {
      this.fetchClockStatus();
    }
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
        this.formattedEndTime = "";
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
            this.formattedEndTime = "";
            return; // Sortir de la méthode sans définir d'erreur
          } else {
            throw new Error(
              "Erreur lors de la récupération de l'état de pointage"
            );
          }
        }

        const result = await response.json();
        const data = result.data;

        if (Array.isArray(data) && data.length > 0) {
          const lastClock = data.sort(
            (a, b) => new Date(b.time) - new Date(a.time)
          )[0];

          if (lastClock) {
            this.clockIn = lastClock.status;
            this.startDateTime = lastClock.time;
            this.formattedStartDateTime = new Date(
              this.startDateTime
            ).toLocaleString("fr-FR");
            this.formattedStartTime = new Date(
              this.startDateTime
            ).toLocaleTimeString("fr-FR", {
              hour: "2-digit",
              minute: "2-digit",
              second: "2-digit",
            });
            this.formattedEndTime = lastClock.status
              ? ""
              : new Date(lastClock.time).toLocaleTimeString("fr-FR", {
                  hour: "2-digit",
                  minute: "2-digit",
                  second: "2-digit",
                });
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
          this.formattedEndTime = "";
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
        this.formattedStartTime = new Date().toLocaleTimeString("fr-FR", {
          hour: "2-digit",
          minute: "2-digit",
          second: "2-digit",
        });
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
        this.formattedEndTime = new Date().toLocaleTimeString("fr-FR", {
          hour: "2-digit",
          minute: "2-digit",
          second: "2-digit",
        });
        this.errorMessage = "";

        // Une fois le dépointage fait, envoyer les données vers l'API des working times
        await this.sendWorkingTime();
      } catch (error) {
        this.errorMessage = `Erreur : ${error.message}`;
      }
    },

    async sendWorkingTime() {
      // Envoi des données du temps de travail
      try {
        const startTime = new Date(this.startDateTime).toISOString();
        const endTime = new Date().toISOString(); // Le temps de fin est celui du dépointage

        const response = await fetch(
          `http://localhost:4000/api/workingtime/${this.selectedUserId}`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              workingtime: {
                start: startTime,
                end: endTime,
              },
            }),
          }
        );

        if (!response.ok) {
          throw new Error(
            "Erreur lors de l'envoi des données de temps de travail"
          );
        }

        this.errorMessage = ""; // Réinitialiser le message d'erreur en cas de succès
      } catch (error) {
        this.errorMessage = `Erreur lors de l'envoi des données de temps de travail : ${error.message}`;
      }
    },

    updateCurrentDateTime() {
      setInterval(() => {
        this.currentDateTime = new Date().toLocaleString("fr-FR", {
          weekday: "long",
          year: "numeric",
          month: "long",
          day: "numeric",
          hour: "2-digit",
          minute: "2-digit",
          second: "2-digit",
        });
      }, 1000);
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
  background-color: #ffffff;
  border-radius: 16px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  border: 1px solid #d1d5db;
}

.btn-primary {
  background-color: #3b82f6;
  color: white;
  padding: 10px 24px;
  border-radius: 24px;
  border: none;
  cursor: pointer;
  transition: background-color 0.3s;
  font-size: 1rem;
  font-weight: 500;
}

.btn-primary:hover {
  background-color: #2563eb;
}

.text-md {
  font-size: 1rem;
  font-weight: 500;
}

.flex {
  display: flex;
}

.justify-center {
  justify-content: center;
}

.justify-between {
  justify-content: space-between;
}

.mb-4 {
  margin-bottom: 1rem;
}

.mt-4 {
  margin-top: 1rem;
}

.px-4 {
  padding-left: 1rem;
  padding-right: 1rem;
}

.rounded-xl {
  border-radius: 1rem;
}
</style>
