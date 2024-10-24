<template>
  <main>
    <RouterView />
    <MDBModal
      id="exampleModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      v-model="localShowModal"
    > 
      <MDBModalHeader>
        <MDBModalTitle id="exampleModalLabel">
          {{ currentDate }} {{ isMorning ? "Morning" : "Afternoon" }}
        </MDBModalTitle>
      </MDBModalHeader>
      <MDBModalBody>
        <div class="data_row d-flex">
          <!-- Mettre dropdown des users de l'équipe -->

          <label for="start">Start </label>
          <input id="start" type="datetime-local" v-model="start" />

          <label for="end">End </label>
          <input id="end" type="datetime-local" v-model="end" />

          <label for="user">Assign to</label>
          <select id="user" v-model="assignedUser">
            <option v-for="user in users" :key="user.id" :value="user.id">
              {{ user.firstname }}
            </option>
          </select>
        </div>
      </MDBModalBody>
      <MDBModalFooter>
        <MDBBtn color="primary" @click="savingWorkingTime">Save changes</MDBBtn>
        <MDBBtn color="secondary" @click="clearAllData">Clear data</MDBBtn>
      </MDBModalFooter>
    </MDBModal>
  </main>
</template>

<script setup>
  import {
    MDBBtn,
    MDBModal,
    MDBModalBody,
    MDBModalFooter,
    MDBModalHeader,
    MDBModalTitle,
  } from "mdb-vue-ui-kit";
  import { RouterView } from "vue-router";
  import { defineProps, defineEmits, onMounted, computed, ref } from "vue";


  const props = defineProps({
    showModal: {
      type: Boolean,
      required: true,
    },
    currentDate: {
      type: Date,
      required: true,
    },
    period: {
      type: Object,
    },
    current_user: {
      type: Object,
    },
    users:{
      type: [],
    },
    from: {
      type: String,
      required: true,
    }
  });

  const start = ref("");
  const end = ref("");
  const isEmpty = ref(true);
  let isMorning = true;
  let method = "POST";

  const formatDateTime = (date) => {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, "0");
    const day = String(date.getDate()).padStart(2, "0");
    const hours = String(date.getHours()).padStart(2, "0");
    const minutes = String(date.getMinutes()).padStart(2, "0");
    console.log(`${year}-${month}-${day}T${hours}:${minutes}`);

    return `${year}-${month}-${day}T${hours}:${minutes}`;
  };

  const formatTime = () => {
    if (props.period && props.period.start) {
      const startDate = new Date(props.period.start);
      const endDate = new Date(props.period.end);

      const hours = startDate.getHours();
      isMorning = hours < 12;

      start.value = formatDateTime(startDate);
      end.value = formatDateTime(endDate);
    } else {
      console.log("Start date is not defined.");
    }
  };

  onMounted(() => {
    console.log(props.period);
    formatTime();
    defineMethod(props.from)
    isEmpty.value = !(start.value && end.value);
  });

  const emit = defineEmits(["closeModal"]);
  const localShowModal = computed({
    get: () => props.showModal,
    set: (value) => {
      if (!value) {
        emit("closeModal");
      }
    },
  });

  const defineMethod = (from) => {
    if(from == "add"){
      method = "POST"
    } else if (from == "modify"){
      method = "PUT"
    }
  }
  
  const clearAllData = async () => {
    try {
      await fetch(
        `http://localhost:4000/api/workingtime/${props.current_user.id}/${props.period.id}`,
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
  };

  const savingWorkingTime = async () => {
    console.log(props.period);
    try {
      await fetch(`http://localhost:4000/api/workingtime/${props.period.id}`, {
        method: method,
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          workingtime: {
            start: new Date(start.value),
            end: new Date(end.value),
          },
        }),
      });
    } catch (error) {
      console.log("Error", error);
    }
  };
</script>


<style>
  #app {
    font-family: Roboto, Helvetica, Arial, sans-serif;
  }

  .data_row {
    justify-content: center;
  }
  .d-flex{
    display: flex;
    flex-direction: column;
  }
</style>
