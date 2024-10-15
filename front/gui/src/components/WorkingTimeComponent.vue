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
          <MDBTable class="align-middle mb-0 bg-white">
            <thead class="bg-light">
              <tr>
                <th>Start</th>
                <th>End</th>
                <th>Update</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="workingTime in workingTimes" :key="workingTime.id">
                <td>{{ workingTime.start }}</td>
                <td>{{ workingTime.end }}</td>
                <td>
                  <MDBBtn color="primary" @click="openModal">Update</MDBBtn>
                  <WorkingTimeModal :showModal="exampleModal" :currentDate="currentDate" :period="workingTime" :current_user="selectedUser" @closeModal="closeModal" />
                </td>
              </tr>
            </tbody>
        </MDBTable>
        </MDBCol>
      </MDBRow>
    </MDBContainer>
  </main>
</template>

  
<script setup>
  import { RouterView } from 'vue-router';
  import WorkingTimeModal from './WorkingTimeModal.vue';
  import { ref } from 'vue';
  const currentDate = "2024-10-10"
  const exampleModal = ref(false)
  const openModal = () => {
      exampleModal.value = true;
  }
  const closeModal = () => {
      exampleModal.value = false;
  }
</script>


<script>
import { MDBContainer, MDBCol, MDBBtn, MDBTable, MDBRow } from "mdb-vue-ui-kit";

export default {
  name: "UserComponent",
  components: {
    MDBContainer,
    MDBCol,
    MDBBtn,
    WorkingTimeModal,
    MDBTable,
    MDBRow
  },
  data() {
    return {
      users: [],
      message: "",
      createUsername: "",
      createEmail: "",
      workingTimes: [],
      selectedUserId: "",
      selectedUser: {
        id: "",
        username: "",
        email: ""
      },
      selectedWorkingTime: {
        id: "",
        start: "",
        end: ""
      }
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
      if (!this.selectedUser.id) return;
      try {
        const response = await fetch(`http://localhost:4000/api/workingtime/${this.selectedUser.id}`);
        this.workingTimes = (await response.json()).data;
      } catch (error) {
        this.message = "Error getting working times: " + error.message;
      }
    },
    selectUser() {
      const currentUser = this.users.find(user => user.id === this.selectedUserId);
      console.log(currentUser);
      if (currentUser) {
        this.selectedUser.id = currentUser.id;
        this.selectedUser.username = currentUser.username;
        this.selectedUser.email = currentUser.email;
        this.getWorkingTimes();
      } else {
        this.selectedUser.username = "";
        this.selectedUser.email = "";
        this.selectedUser.id = "";
        this.workingTimes = [];
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

