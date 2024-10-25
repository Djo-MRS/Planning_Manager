<template>
  <div class="container-grid">
      <div class="main-content">      
          <ProfileComponent />
      </div>
      <section class="right-bar">
          <RightBarComponent @tutoClicked="Tutorial"/>
      </section>
      <AlerteBatmanComponent ref="alerte" />
      <NavBarComponent />
  </div>
</template>

<script>
import AlerteBatmanComponent from '@/components/AlerteBatmanComponent.vue';
import NavBarComponent from '@/components/NavBarComponent.vue';
import ProfileComponent from '@/components/ProfileComponent.vue';
import RightBarComponent from '@/components/RightBarComponent.vue';
import { driver } from "driver.js"; 
import "driver.js/dist/driver.css"; 

export default {
  name: 'ProfileView',
  components: {
    AlerteBatmanComponent,
    ProfileComponent,
    NavBarComponent,
    RightBarComponent,
  },
  methods: {
        Tutorial() {
            const tuto = driver({
                showProgress: true,
                steps: [
                    { element: '#profil-display', popover: { title: 'Profil', description: 'Affichage des différents éléments de votre profil. Si besoin de modifications, veuillez vous adresser à votre manager ou à l\'admin', side: "right", align: 'start'}}
                ]
            });

            tuto.drive();
        }
    }
};
</script>

<style>
  .contnr-grid{
    display: flex;
    padding: 40px
  }

  @media (max-width: 768px) {
      .contnr-grid{
          justify-content: center;
          padding: 0px
      }
  }
</style>