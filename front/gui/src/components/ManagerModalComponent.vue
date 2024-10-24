<template>
  <main>
    <MDBModal
      id="exampleModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      v-model="localShowModal"
    >
      <MDBModalHeader>
        <MDBModalTitle id="exampleModalLabel"></MDBModalTitle>
      </MDBModalHeader>
      <MDBModalBody>
        <div class="data_row d-flex">
          <label for="start">Début : </label>
          <input id="start" type="datetime-local" v-model="start" />

          <label for="end">Fin : </label>
          <input id="end" type="datetime-local" v-model="end" />

          <label for="user">Assigné à :</label>
          <div v-if="current_user">
            {{ current_user.firstname }}
          </div>
          <div v-else>
            <select id="user" v-model="assignedUser">
              <option v-for="user in users" :key="user.id" :value="user.id">
                {{ user.firstname }}
              </option>
            </select>
          </div>
        </div>
      </MDBModalBody>
      <MDBModalFooter>
        <MDBBtn color="primary" @click="savingWorkingTime">Save changes</MDBBtn>
        <MDBBtn color="secondary" @click="clearAllData">Clear data</MDBBtn>
      </MDBModalFooter>
    </MDBModal>
  </main>
</template>

<script>
import {
  MDBBtn,
  MDBModal,
  MDBModalBody,
  MDBModalFooter,
  MDBModalHeader,
  MDBModalTitle,
} from "mdb-vue-ui-kit";

export default {
  data() {
    return {
      start: "",
      end: "",
      method: "POST",
      assignedUser: "",
      localShowModal: this.showModal,
    };
  },
  components: {
    MDBBtn,
    MDBModal,
    MDBModalBody,
    MDBModalFooter,
    MDBModalHeader,
    MDBModalTitle,
  },
  props: {
    showModal: {
      type: Boolean,
      required: true,
    },
    currentDate: {
      type: Date,
      required: true,
    },
    task: {
      type: Object,
    },
    current_user: {
      type: Object,
    },
    users: {
      type: Array,
    },
    from: {
      type: String,
      default: "",
      required: true,
    },
  },
  watch: {
    showModal(val) {
      this.localShowModal = val;
      if (!val) {
        this.$emit("closeModal");
      }
    },
  },
  methods: {
    formatDateTime(date) {
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, "0");
      const day = String(date.getDate()).padStart(2, "0");
      const hours = String(date.getHours()).padStart(2, "0");
      const minutes = String(date.getMinutes()).padStart(2, "0");
      return `${year}-${month}-${day}T${hours}:${minutes}`;
    },
    formatTime() {
      if (this.task && this.task.start) {
        const startDate = new Date(this.task.start);
        const endDate = new Date(this.task.end);
        this.start = this.formatDateTime(startDate);
        this.end = this.formatDateTime(endDate);
      } else {
        console.log("task or start date is not defined.");
      }
    },
    clearAllData: async function () {
      try {
        await fetch(
          `http://localhost:4000/api/workingtime/${this.current_user.id}/${this.task.id}`,
          {
            method: "DELETE",
            headers: {
              "Content-Type": "application/json",
            },
          }
        );
      } catch (error) {
        console.log("Error", error);
      }
    },
    defineMethod(from) {
      if (from === "add") {
        this.method = "POST";
      } else if (from === "modify") {
        this.method = "PUT";
      }
    },
    async savingWorkingTime() {
      try {
        await fetch(`http://localhost:4000/api/workingtime/${this.task.id}`, {
          method: this.method,
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            workingtime: {
              start: new Date(this.start),
              end: new Date(this.end),
            },
          }),
        });
      } catch (error) {
        console.log("Error", error);
      }
    },
  },
  mounted() {
    this.defineMethod(this.from);
    this.formatTime();
  },
};
</script>

<style>
#app {
  font-family: Roboto, Helvetica, Arial, sans-serif;
}

.data_row {
  justify-content: center;
}

.d-flex {
  display: flex;
  flex-direction: column;
}
</style>
