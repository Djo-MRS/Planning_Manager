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
    <MDBBtn color="primary" @click="openModal">fezbfubze</MDBBtn>
    <WorkingTimeModal :showModal="exampleModal" :currentDate="currentDate" :period="period" :current_user="current_user" @closeModal="closeModal" />
  </main>
</template>

  
<script setup>
  import { RouterView } from 'vue-router';
  import WorkingTimeModal from './WorkingTimeModal.vue';
  import { ref } from 'vue';
  const currentDate = "2024-10-10"
  const period = {
      start: "2024-10-08T14:00:00Z",
      end: "2024-10-08T17:30:00Z",
  }
  const current_user = {
      id: "1",
      firstname: "Yann",
      lastname: "Plouhinec",
  }
  const exampleModal = ref(false)
  const openModal = () => {
      console.log('ici')
      exampleModal.value = true;
  }
  const closeModal = () => {
      exampleModal.value = false;
  }
</script>


<script>
import { MDBContainer, MDBCol, MDBBtn } from "mdb-vue-ui-kit";

export default {
  name: "UserComponent",
  components: {
    MDBContainer,
    MDBCol,
    MDBBtn,
    WorkingTimeModal
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

