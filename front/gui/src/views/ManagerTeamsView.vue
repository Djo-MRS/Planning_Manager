<template>
  <div class="container-grid">
      <div class="main-content">      
          <TeamsComponent />
      </div>
      <section class="right-bar">
          <RightBarComponent/>
      </section>
      <NavBarComponent />
  </div>
</template>
  
<script>
import NavBarComponent from '@/components/NavBarComponent.vue';
import RightBarComponent from '@/components/RightBarComponent.vue';
import TeamsComponent from '@/components/TeamsComponent.vue';
  
export default {
  name: 'ManagerTeamsView',
  components: {
    TeamsComponent,
    NavBarComponent,
    RightBarComponent,
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
  flex-direction: row; 
  height: 100vh; 
  overflow: hidden; 
}

.main-content {
  flex: 1; 
  padding: 50px;
  overflow-y: auto; 
}

.right-bar {
  width: 80px;
}

.nav-bar {
  display: flex;
  justify-content: center;
  position: fixed;
  bottom: 20px;
  left: 0;
  right: 0;
}
</style>