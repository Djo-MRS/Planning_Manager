<template>
  <main>
    <RouterView />
    <MDBContainer>
      <MDBRow>
        <MDBCol>
          <h2>Select a user</h2>
          <select
            v-model="selectedUserId"
            @change="selectUser"
            class="
              form-select
              form-select-lg
              mb-3
              mt-3
              col-6
            "
          >
            <option disabled value="">Select a user</option>
            <option v-for="user in users" :key="user.id" :value="user.id">
              {{ user.username }}
            </option>
          </select>
        </MDBCol>
      </MDBRow>
      <MDBRow>
        <MDBCol>
          <h2>Working Times</h2>
          <ul v-if="workingTimes.length">
            <li v-for="time in workingTimes" :key="time.id">
              {{ time.date }}: {{ time.hours }}
            </li>
          </ul>
          <p v-else>No working times available.</p>
        </MDBCol>
      </MDBRow>
    </MDBContainer>
  </main>
</template>

  
<script>
import { MDBContainer, MDBCol } from "mdb-vue-ui-kit";

export default {
  name: "UserComponent",
  components: {
    MDBContainer,
    MDBCol,
  },
  data() {
    return {
      username: "",
      email: "",
      users: [],
      selectedUserId: "",
      message: "",
      createUsername: "",
      createEmail: "",
      workingTimes: []  // Nouveau tableau pour stocker les heures de travail
    };
  },
  mounted() {
    this.getUsers();
  },
  methods: {
    async getUsers() {
      try {
        const response = await fetch("http://localhost:4000/api/users");
        this.users = (await response.json()).data;
      } catch (error) {
        this.message = "Error getting users: " + error.message;
      }
    },
    async getWorkingTimes() {
      if (!this.selectedUserId) return;  // Ne pas récupérer si aucun utilisateur n'est sélectionné
      try {
        const response = await fetch(`http://localhost:4000/api/users/${this.selectedUserId}/workingtimes`);
        this.workingTimes = (await response.json()).data;
      } catch (error) {
        this.message = "Error getting working times: " + error.message;
      }
    },
    selectUser() {
      const selectedUser = this.users.find(user => user.id === this.selectedUserId);
      if (selectedUser) {
        this.username = selectedUser.username;
        this.email = selectedUser.email;
        this.getWorkingTimes();  // Appel de la fonction pour récupérer les heures de travail
      } else {
        this.username = "";
        this.email = "";
        this.workingTimes = [];  // Réinitialiser les heures de travail si aucun utilisateur n'est sélectionné
      }
    }
  }
}
</script>
  
  <style>
  #app {
    font-family: Roboto, Helvetica, Arial, sans-serif;
  }
  </style>

