<template>
  <div class="container-grid">
      <div class="main-manager-dashboard ">      
          <ManagerCalendarComponent />
      </div>
      <section class="right-bar">
          <RightBarComponent @tutoClicked="Tutorial" />
      </section>
      <AlerteBatmanComponent ref="alerte" />
      <NavBarComponent />
  </div>
</template>
  
<script>
import AlerteBatmanComponent from '@/components/AlerteBatmanComponent.vue';
import ManagerCalendarComponent from '@/components/ManagerCalendarComponent.vue';
import NavBarComponent from '@/components/NavBarComponent.vue';
import RightBarComponent from '@/components/RightBarComponent.vue';
import { driver } from "driver.js"; 
import "driver.js/dist/driver.css"; 

export default {
  name: 'ManagerDashboardView',
  components: {
    AlerteBatmanComponent,
    ManagerCalendarComponent,
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
  methods: {
        Tutorial() {
            const tuto = driver({
                showProgress: true,
                steps: [
                    { element: '#dashboard-display', popover: { title: 'Dashboard', description: 'Emploi du temps de vos équipes.', side: "top", align: 'start'}},
                    { element: '#dashboard-team', popover: { title: 'Equipe', description: 'Faites défiler pour naviguer entre vos différentes équipes.', side: "bottom", align: 'start'}},
                    { element: '#dashboard-task', popover: { title: 'Tâche', description: 'Ajoutez une tâche à un membre de votre équipe.', side: "bottom", align: 'start'}},
                    { element: '#dashboard-addteam', popover: { title: 'Nouvelle Equipe', description: 'Créez de nouvelles équipes ou modifiez celles existantes', side: "bottom", align: 'start'}},                    
                ]
            });

            tuto.drive();
        }
    }
};
</script>
  
<style>
.container-grid {
  display: flex;
  flex-direction: column; 
  height: 100%; 
}

.main-manager-dashboard {
  flex: 1; 
  margin-right: 20px;
  margin-left: 20px;
}

.right-bar {
  width: 80px;
}

</style>
