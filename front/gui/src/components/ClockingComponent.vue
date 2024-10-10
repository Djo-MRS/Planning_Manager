<template>
    <div class="clocking">
      <h3>Clocking</h3>
      <div v-if="errorMessage">
        <p>{{ errorMessage }}</p>
      </div>
      <div v-else>
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
        userId: this.$route.params.userId,
        clockIn: false,
        startDateTime: null,
        formattedStartDateTime: '',
        errorMessage: ''
      };
    },
    methods: {
      async fetchClockStatus() {
        try {
          const response = await fetch(`http://localhost:4000/api/clocks/${this.userId}`, {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
            }
          });
          if (!response.ok) {
            throw new Error("ID utilisateur non trouvé");
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
          this.errorMessage = "Erreur : ID utilisateur non trouvé";
        }
      },
      async clockInUser() {
        try {
          const response = await fetch(`http://localhost:4000/api/clocks/${this.userId}`, {
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
            throw new Error("ID utilisateur non trouvé");
          }
          await response.json();
          this.clockIn = true;
          this.startDateTime = new Date().toISOString();
          this.formattedStartDateTime = new Date().toLocaleString('fr-FR');
          this.errorMessage = '';
        } catch (error) {
          console.error("Error clocking in", error);
          this.errorMessage = "Erreur : ID utilisateur non trouvé";
        }
      },
      async clockOut() {
        try {
          const response = await fetch(`http://localhost:4000/api/clocks/${this.userId}`, {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              clock: {
                clockIn: false,
                time: new Date().toISOString()
              }
            })
          });
          if (!response.ok) {
            throw new Error("ID utilisateur non trouvé");
          }
          await response.json();
          this.clockIn = false;
          this.startDateTime = null;
          this.errorMessage = '';
        } catch (error) {
          console.error("Error clocking out", error);
          this.errorMessage = "Erreur : ID utilisateur non trouvé";
        }
      },
      refresh() {
        this.fetchClockStatus();
      },
      clock() {
        if (this.clockIn) {
          this.clockOut();
        } else {
          this.clockInUser();
        }
      }
    },
    created() {
      this.fetchClockStatus();
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