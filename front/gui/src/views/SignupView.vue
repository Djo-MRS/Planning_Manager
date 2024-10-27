<template>
    <div class="container-grid">
        <div class="main-content">      
            <SignupComponent />
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
import SignupComponent from '@/components/SignupComponent.vue';
import { driver } from "driver.js"; 
import "driver.js/dist/driver.css"; 

export default {
    name: 'SignupView',
    components: {
        SignupComponent,
        RightBarComponent,
        AlerteBatmanComponent,
        NavBarComponent,

    },
    methods: {
        Tutorial() {
            const tuto = driver({
                showProgress: true,
                steps: [
                    { element: '#signup-add', popover: { title: 'Création d\'utlisateur.', description: 'Créer un utlisateur à partir de ce formulaire.', side: "right", align: 'start'}},
                    { element: '#signup-modify', popover: { title: 'Modification.', description: 'Choisir un utilisateur dans le menu déroulant. Modifier le profil sous le formulaire sur votre gauche si besoin', side: "bottom", align: 'start'}},
                    { element: '#signup-delete', popover: { title: 'Suppression.', description: 'Cliquer sur le bouton pour supprimer l\'utilisateur. ATTENTION TOUTE SUPPRESSION EST DEFINITVE !!!', side: "bottom", align: 'start'}},         
                ]
            });

            tuto.drive();
        },

      goToSignin() {
        this.$router.push('/sign_in');
      }
    },
}
</script>

<style>
    

    .home-button {
        position: fixed;
        top: 20px;
        right: 20px;
        width: 40px;
        height: 40px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 20px;
        font-size: 24px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .home-button:hover {
        background-color: #0056b3; 
    }

    .icon {
        font-size: 20px; 
    }
</style>