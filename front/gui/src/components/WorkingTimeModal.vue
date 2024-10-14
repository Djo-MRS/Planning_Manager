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
              <MDBModalTitle id="exampleModalLabel"> {{currentDate}} {{isMorning ? "Morning": "Afternoon" }} </MDBModalTitle>
          </MDBModalHeader>
          <MDBModalBody>
              <div class="data_row d-flex">
                  <label for="start">Start </label>
                  <input id="start" type="time" v-model="start" />

                  <label for="end">End </label>
                  <input id="end" type="time" v-model="end" />
              
              </div>
          </MDBModalBody>
          <MDBModalFooter>    
              <MDBBtn color="primary" @click="defineSavingMethod">Save changes</MDBBtn>
              <MDBBtn color="secondary" @click="clearAllData">Clear data</MDBBtn>
          </MDBModalFooter>
      </MDBModal> 
  </main>
</template>

<script setup>
  import { MDBBtn, MDBModal, MDBModalBody, MDBModalFooter, MDBModalHeader, MDBModalTitle } from 'mdb-vue-ui-kit';
  import { RouterView } from 'vue-router';
  import { defineProps, defineEmits, onMounted, computed, ref,  } from 'vue';

  const props = defineProps({
      showModal: {
          type: Boolean,
          required: true
      },
      currentDate :{
          type: Date,
          required: true,
      },
      period: {
          type: Object,
      },
      current_user: {
          type: Object,
      },

  });
  const start = ref(props.period.start);
  const end = ref(props.period.end);
  const isEmpty = ref(true);
  let isMorning = true;
  let method = '';
  const formatTime=()=>{
      if (props.period && props.period.start) {
          const startDate = new Date(props.period.start);
          const hours = startDate.getHours();
          
          const isBeforeNoon = hours < 12;

          if (isBeforeNoon) {
              console.log("C'est le matin.");
              isMorning = true
          } else {
              console.log("C'est l'après-midi ou le soir.");
              isMorning = false
          }
          start.value = startDate.toTimeString().slice(0, 5);
          const endDate = new Date(props.period.end);
          end.value = endDate.toTimeString().slice(0, 5);
      } else {
          console.log("La date de début n'est pas définie.");
      }
  }

  onMounted(()=>{
      formatTime()
      isEmpty.value = !(start.value && end.value);
  });

  /*watch(()=> props.period, (newValue) => {
      formatTime();
  }, {immediate :true})*/

  const emit = defineEmits(['closeModal']);
  console.log('currentDate:', props.currentDate);
  console.log('period:', props.period);
  const localShowModal = computed({
      get: ()=> props.showModal, 
      set: (value) => {
          if(!value){
              emit('closeModal')
          }
      }
  });

  const defineSavingMethod=()=>{
      if(isEmpty.value){
          console.log('Define method POST')
          method = "POST"
      } else {
          console.log('Define method PUT')

          method = "PUT"
      }
      savingWorkingTime()
  }
  const clearAllData=async()=>{
      //faire appel workingtime delete
      console.log('clearing...')
      try {
          await fetch(`http://localhost:4000/api/workingtime/${props.current_user.id}`, {
              method: "DELETE",
              headers: {
                  "Content-Type": "application/json"
              },
          });
      } catch (error) {
          console.log('Error', error);
      }
  }

  const savingWorkingTime=async()=>{
      //faire appel workingtime create_workingtime_by_user
      console.log('saving...')
      try {
          await fetch(`http://localhost:4000/api/workingtime/${props.current_user.id}`, {//mettre userID
              method: method,
              headers: {
                  "Content-Type": "application/json"
              },
              body: JSON.stringify({
                  workingtime: {
                      start: start,
                      end: end
                  }
              })
          });
      } catch (error) {
          console.log('Error', error);
      }
  }
</script>

<style>
#app {
  font-family: Roboto, Helvetica, Arial, sans-serif;
}

.data_row{
  justify-content: center;
}
</style>