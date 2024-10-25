<template>
  <div class="container-grid">
      <div class="main-content">      
          <ManagerComponent />
          <h2>Planning des employés</h2>
          <CalendarComponent />
      </div>
      <section class="right-bar">
          <RightBarComponent/>
      </section>
      <NavBarComponent />
  </div>
</template>
  
<script>
import ManagerComponent from '@/components/ManagerComponent.vue';
import CalendarComponent from '@/components/CalendarComponent.vue'; 
import NavBarComponent from '@/components/NavBarComponent.vue';
import RightBarComponent from '@/components/RightBarComponent.vue';
  
export default {
  name: 'ManagerDashboardView',
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
.container-grid {
  display: flex;
  flex-direction: column; 
  height: 100vh; 
}

.main-content {
  flex: 1; 
  margin: 0 20px; 
}

.right-bar {
  width: 80px;
}


</style>
