<template>
  <div class="container-grid">
    <div class="main-content">      
      <ManagerComponent />
    </div>
  <section class="right-bar">
    <RightBarComponent/>
  </section>
  <NavBarComponent />
  </div>
  <ManagerComponent :is-admin="isAdmin" />
  <div v-if="isManager">
    <h2>Planning des employés</h2>
    <CalendarComponent />
  </div>
</template>
  
  <script>
  import ManagerComponent from '@/components/ManagerComponent.vue';
  import CalendarComponent from '@/components/CalendarComponent.vue'; 
import NavBarComponent from '@/components/NavBarComponent.vue';
import RightBarComponent from '@/components/RightBarComponent.vue';
  
  export default {
    name: 'ManagerView',
    components: {
      ManagerComponent,
      NavBarComponent,
      RightBarComponent,
      CalendarComponent,
    },
    computed: {
      isManager() {
        return localStorage.getItem('roleId') === 'manager';
      },
      isAdmin() {
        return localStorage.getItem('roleId') === 'admin';
      },
    },
  };
  </script>
  
  <style>
  </style>
