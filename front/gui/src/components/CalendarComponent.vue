<template>
    <FullCalendar :options="calendarOptions" />
  </template>
  
  <script>
  import FullCalendar from '@fullcalendar/vue3';
  import timeGridPlugin from '@fullcalendar/timegrid';
  
  export default {
    name: 'CalendarComponent',
    components: {
      FullCalendar
    },
    data() {
      return {
        workingTimes: [],
        calendarOptions: {
          plugins: [timeGridPlugin],
          initialView: 'timeGridWeek',
          events: [],
          height: 600,
        }
      };
    },
    mounted() {
      this.getWorkingTimes();
    },
    methods: {
      async getWorkingTimes() {
        try {
          const response = await fetch('http://localhost:4000/api/workingtime/8');
          const data = await response.json();
  
          console.log("data length: ", data.data.length);
  
          this.workingTimes = [];
  
          for (let i = 0; i < data.data.length; i++) {
            console.log("item : " + data.data[i].start);
            this.workingTimes.push({
              title: 'Working time',
              start: data.data[i].start,
              end: data.data[i].end
            });
          }
  
          this.calendarOptions = {
            ...this.calendarOptions,
            events: [...this.workingTimes], // Set new events array
          };
  
          console.log("Updated workingTimes: ", this.workingTimes);
  
        } catch (error) {
          console.error("Error fetching working times: ", error);
        }
      }
    }
  };
  </script>
  
  <style>
  #app {
    font-family: Roboto, Helvetica, Arial, sans-serif;
  }
  </style>
  