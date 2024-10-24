<template>
  <div
    class="clocking p-6 max-w-lg mx-auto bg-white rounded-xl shadow-md space-y-4"
  >
    <div class="mb-4">
      <label
        for="userSelect"
        class="block text-sm font-medium text-gray-700 mb-2"
        >{{ user.firstname + " " + user.lastname }}</label
      >
    </div>
    <div v-if="user.id" class="mt-4">
      <h3 class="text-xl font-bold text-center text-gray-700 mb-4">
        {{ currentDateTime }}
      </h3>
      <div class="flex justify-center mb-4">
        <button v-if="!status" @click="clockInUser" class="btn btn-primary">
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
      user: {},
      status: false,
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
    this.user = JSON.parse(localStorage.getItem("user"));
    console.log(document.cookie);

    this.updateCurrentDateTime();
    if (this.user.id) {
      this.fetchClockStatus();
    }
  },
  methods: {
    async fetchClockStatus() {
      this.errorMessage = "";
      const csrfToken = document.cookie.split("c-xsrf-token=")[1]?.split(";")[0];
      const token = localStorage.getItem("token");

      try {
        const response = await fetch(
          `/api/clocks/${this.user.id}`,
          {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
              "Authorization": `Bearer ${token}`,
              "X-CSRF-Token": csrfToken, 
            },
            credentials: "include"
          }
        );

        if (!response.ok) {
          if (response.status === 404) {
            this.status = false;
            this.lastAction = null;
            this.startDateTime = null;
            this.formattedStartDateTime = "";
            this.formattedEndTime = "";
            return;
          } else {
            throw new Error("Erreur lors de la récupération de l'état de pointage");
          }
        }

        const result = await response.json();
        const data = result.data;

        if (Array.isArray(data) && data.length > 0) {
          const lastClock = data.sort((a, b) => new Date(b.time) - new Date(a.time))[0];

          if (lastClock) {
            this.status = lastClock.status;
            this.startDateTime = lastClock.time;
            this.formattedStartDateTime = new Date(this.startDateTime).toLocaleString("fr-FR");
            this.formattedStartTime = new Date(this.startDateTime).toLocaleTimeString("fr-FR", {
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
            this.lastAction = lastClock.status ? "status" : "clockOut";
          } else {
            this.status = false;
            this.lastAction = null;
          }
        } else {
          this.status = false;
          this.lastAction = null;
          this.startDateTime = null;
          this.formattedStartDateTime = "";
          this.formattedEndTime = "";
        }
      } catch (error) {
        console.error("Erreur lors de la récupération de l'état de pointage", error);
        this.errorMessage = `Erreur : ${error.message}`;
      }
    },

    async clockInUser() {
      const csrfToken = document.cookie.split("c-xsrf-token=")[1]?.split(";")[0];
      try {
        const response = await fetch(
          `/api/clocks/${this.user.id}`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer " + localStorage.getItem("token"),
              "X-CSRF-Token": csrfToken,
            },
            credentials: "include",
            body: JSON.stringify({
              clock: {
                status: true,
                time: new Date().toISOString(),
              },
            }),
          }
        );
        if (!response.ok) {
          throw new Error("Erreur lors du pointage");
        }
        await response.json();
        this.status = true;
        this.startDateTime = new Date().toISOString();
        this.formattedStartDateTime = new Date().toLocaleString("fr-FR");
        this.formattedStartTime = new Date().toLocaleTimeString("fr-FR", {
          hour: "2-digit",
          minute: "2-digit",
          second: "2-digit",
        });
        this.lastAction = "status";
        this.errorMessage = "";
      } catch (error) {
        this.errorMessage = `Erreur : ${error.message}`;
      }
    },

    async clockOut() {
      const csrfToken = document.cookie.split("c-xsrf-token=")[1]?.split(";")[0];
      try {
        const response = await fetch(
          `/api/clocks/${this.user.id}`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer " + localStorage.getItem("token"),
              "X-CSRF-Token": csrfToken, 
            },
            credentials: "include",
            body: JSON.stringify({
              clock: {
                status: false,
                time: new Date().toISOString(),
              },
            }),
          }
        );
        if (!response.ok) {
          throw new Error("Erreur lors du dépointage");
        }
        await response.json();

        this.status = false;
        this.lastAction = "clockOut";
        this.formattedEndTime = new Date().toLocaleTimeString("fr-FR", {
          hour: "2-digit",
          minute: "2-digit",
          second: "2-digit",
        });

        this.errorMessage = "";

        // N'envoyez que le temps de travail une fois que l'heure de fin est bien définie
        await this.sendWorkingTime();
      } catch (error) {
        this.errorMessage = `Erreur : ${error.message}`;
      }
    },


    async sendWorkingTime() {
      const csrfToken = document.cookie.split("c-xsrf-token=")[1]?.split(";")[0];
      const token = localStorage.getItem("token");

      try {
        const startTime = new Date(this.startDateTime).toISOString();
        const endTime = new Date().toISOString();

        const response = await fetch(
          `/api/workingtime/${this.user.id}`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "Authorization": `Bearer ${token}`,
              "X-CSRF-Token": csrfToken,
            },
            credentials: "include",
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

        this.errorMessage = "";
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
      if (this.user.id) {
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
