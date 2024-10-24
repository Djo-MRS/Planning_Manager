<template>
  <div>
    <FullCalendar ref="fullCalendar" :options="calendarOptions" />

    <div v-if="showModal" class="modal-overlay">
      <div class="modal-content">
        <h3>Modifier Working Time</h3>
        <label for="start-date">Date de début :</label>
        <input type="datetime-local" v-model="editedEvent.start" />

        <label for="end-date">Date de fin :</label>
        <input type="datetime-local" v-model="editedEvent.end" />

        <div class="modal-actions">
          <MDBButton @click="saveChanges">Enregistrer</MDBButton>
          <MDBButton @click="closeModal">Annuler</MDBButton>
        </div>
      </div>
    </div>
  </div>
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
      showModal: false,
      editedEvent: {
        id: null,
        start: '',
        end: ''
      },
      workingTimes: [],
      calendarOptions: {
        plugins: [timeGridPlugin, dayGridPlugin],
        initialView: 'timeGridWeek',
        events: [],
        eventClick: this.handleEventClick,
      }
    };
  },
  mounted() {
    this.getWorkingTimes();
    this.adjustForMobile();
    window.addEventListener('resize', this.adjustForMobile); 
  },
  beforeUnmount() {
    window.removeEventListener('resize', this.adjustForMobile); 
  },
  methods: {
    async getWorkingTimes() {
      const csrfToken = document.cookie.split("c-xsrf-token=")[1]?.split(";")[0];
      const token = localStorage.getItem("token");

      try {
        const userId = JSON.parse(localStorage.getItem('user')).id;
        const response = await fetch('/api/workingtime/'+ userId,
          {
            method: 'GET',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${token}`,
              'X-CSRF-Token': csrfToken,
            },
            credentials: 'include'
          }
        );
        const data = await response.json();
  
        this.workingTimes = [];
  
        for (let i = 0; i < data.data.length; i++) {
          this.workingTimes.push({
            id: data.data[i].id,
            title: 'Working time',
            start: data.data[i].start,
            end: data.data[i].end
          });
        }
  
        this.calendarOptions = {
          ...this.calendarOptions,
          events: [...this.workingTimes],
        };

        console.log(this.workingTimes);
  
      } catch (error) {
        console.error("Error fetching working times: ", error);
      }
    },

    handleEventClick(info) {
      
      this.editedEvent = {
        id: info.event.id,
        start: `${info.event.start.getFullYear()}-${(info.event.start.getMonth() + 1).toString().padStart(2, 0)}-${info.event.start.getDate().toString().padStart(2, 0)}T${info.event.start.getHours().toString().padStart(2, 0)}:${info.event.start.getMinutes().toString().padStart(2, 0)}`,
        end: `${info.event.end.getFullYear()}-${(info.event.end.getMonth() + 1).toString().padStart(2, 0)}-${info.event.end.getDate().toString().padStart(2, 0)}T${info.event.end.getHours().toString().padStart(2, 0)}:${info.event.end.getMinutes().toString().padStart(2, 0)}`
      };
      this.showModal = true;
    },

    async saveChanges() {
      const csrfToken = document.cookie.split("c-xsrf-token=")[1]?.split(";")[0];
      const token = localStorage.getItem("token");

      try {
        const response = await fetch(`/api/workingtime/${this.editedEvent.id}`,
          {
            method: 'PUT',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${token}`,
              'X-CSRF-Token': csrfToken,
            },
            credentials: 'include',
            body: JSON.stringify({
              workingtime: {
                start: new Date(this.editedEvent.start).toISOString(),
                end: new Date(this.editedEvent.end).toISOString(),
              }
            })
          }
        );
        if (response.ok) {
          const updatedEvent = this.workingTimes.find(event => event.id === this.editedEvent.id);
          if (updatedEvent) {
            updatedEvent.start = this.editedEvent.start;
            updatedEvent.end = this.editedEvent.end;
          }
          this.closeModal();
          this.calendarOptions.events = [...this.workingTimes];
        } else {
          console.error("Erreur lors de la mise à jour de l'événement");
        }
      } catch (error) {
        console.error("Erreur lors de la requête : ", error);
      }
    },

    closeModal() {
      this.showModal = false;
    },

    adjustForMobile() {
      const isMobile = window.innerWidth <= 768;
      const calendarApi = this.$refs.fullCalendar.getApi();

      if (isMobile) {
        const today = new Date();
        calendarApi.changeView('timeGridDay');
        calendarApi.gotoDate(today);
      } else {
        calendarApi.changeView('timeGridWeek');
      }
    }
  }
};
</script>

<style>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1;
}

.modal-content {
  background-color: white;
  padding: 20px;
  border-radius: 8px;
  min-width: 300px;
  max-width: 75%;
  margin: 0 20px;
}

.modal-actions {
  display: flex;
  justify-content: space-between;
  margin: 10px;
}

.modal-actions button {
  padding: 8px 12px;
}

.fc {
    max-height: 80vh; 
    overflow: auto; 
}

</style>