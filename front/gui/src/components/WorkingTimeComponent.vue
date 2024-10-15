<template>
  <MDBRow>
    <MDBCol md="4">
      <ClockingComponent />
    </MDBCol>
    <MDBCol md="8">
      <CalendarComponent />
    </MDBCol>
  </MDBRow>
</template>

<script>
import CalendarComponent from '@/components/CalendarComponent.vue';
import ClockingComponent from '@/components/ClockingComponent.vue';
import { MDBRow, MDBCol } from 'mdb-vue-ui-kit';

export default {
  name: 'WorkingTimeComponent',
  components: {
    CalendarComponent,
    ClockingComponent,
    MDBRow,
    MDBCol,
  }
}
</script>

<style>
#app {
  font-family: Roboto, Helvetica, Arial, sans-serif;
}
</style>
