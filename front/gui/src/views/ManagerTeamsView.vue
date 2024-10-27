<template>
  <div class="container-grid">
      <div class="main-content">      
          <TeamsComponent />
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
import NavBarComponent from '@/components/NavBarComponent.vue';
import RightBarComponent from '@/components/RightBarComponent.vue';
import TeamsComponent from '@/components/TeamsComponent.vue';
import { driver } from "driver.js"; 
import "driver.js/dist/driver.css"; 
  
export default {
  name: 'ManagerTeamsView',
  components: {
    AlerteBatmanComponent,
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

  methods: {
        Tutorial() {
            const tuto = driver({
                showProgress: true,
                steps: [
                    { element: '#team-add', popover: { title: 'Création d\'équipes', description: 'Pour créer une nouvelle équipe, la modifier ou la supprimer.', side: "bottom", align: 'start'}},
                    { element: '#team-list', popover: { title: 'Equipes', description: 'Faire défiler pour naviguer entre vos différentes équipes.', side: "right", align: 'start'}},
                    { element: '#team-action', popover: { title: 'Tâches', description: 'Tableau des actions en cours à affecter aux équipes.', side: "right", align: 'start'}},
                    { element: '#team-task', popover: { title: 'Listing', description: 'Listing des différents utilisateurs par équipes', side: "left", align: 'start'}},                    
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