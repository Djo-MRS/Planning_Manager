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
  .main-content{
      padding: 50px;
  }
</style>