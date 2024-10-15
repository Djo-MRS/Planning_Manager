<template>
  <CalendarComponent />
</template>

<script>
import CalendarComponent from '@/components/CalendarComponent.vue';

export default {
  name: 'WorkingTimeComponent',
  components: {
    CalendarComponent
  }
}
</script>

<style>
#app {
  font-family: Roboto, Helvetica, Arial, sans-serif;
}
</style>
