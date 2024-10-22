<template>
  <FullCalendar ref="fullCalendar" :options="calendarOptions" />
</template>

<script>
import FullCalendar from '@fullcalendar/vue3';
import timeGridPlugin from '@fullcalendar/timegrid';
import dayGridPlugin from '@fullcalendar/daygrid';

export default {
  name: 'CalendarComponent',
  components: {
    FullCalendar
  },
  data() {
    return {
      workingTimes: [],
      calendarOptions: {
        plugins: [timeGridPlugin, dayGridPlugin],
        initialView: 'timeGridWeek',
        events: [],
        height: 600,
      }
    };
  },
  mounted() {
    this.getWorkingTimes();
    this.adjustForMobile();
    window.addEventListener('resize', this.adjustForMobile); // Écouteur d'événements pour détecter les changements d'écran
  },
  beforeUnmount() {
    window.removeEventListener('resize', this.adjustForMobile); // Supprimer l'écouteur d'événements quand le composant est démonté
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
          events: [...this.workingTimes], // Met à jour les événements
        };
  
        console.log("Updated workingTimes: ", this.workingTimes);
  
      } catch (error) {
        console.error("Error fetching working times: ", error);
      }
    },

    adjustForMobile() {
      const isMobile = window.innerWidth <= 768; // Détecter si l'écran est mobile
      const calendarApi = this.$refs.fullCalendar.getApi(); // Obtenir l'instance FullCalendar

      if (isMobile) {
        const today = new Date(); // Obtenir la date actuelle
        calendarApi.changeView('timeGridDay'); // Changer la vue à la journée
        calendarApi.gotoDate(today); // Se positionner sur aujourd'hui
      } else {
        calendarApi.changeView('timeGridWeek'); // Revenir à la vue hebdomadaire
      }
    }
  }
};
</script>

<style>
  #app {
    font-family: Roboto, Helvetica, Arial, sans-serif;
  }

  @media (max-width: 768px) {
        .fc .fc-toolbar{
            display: block;
        }
    }
</style>
