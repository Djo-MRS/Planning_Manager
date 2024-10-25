<template>
    <div class="container-grid">
        <div class="main-content">      
            <WorkingTimeComponent />
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
import RightBarComponent from '@/components/RightBarComponent.vue';
import WorkingTimeComponent from '@/components/WorkingTimeComponent.vue';
import { driver } from "driver.js"; 
import "driver.js/dist/driver.css"; 

export default {
    name: 'HomeView',
    components: {
        WorkingTimeComponent,
        RightBarComponent,
        NavBarComponent,
        AlerteBatmanComponent,
    },
    methods: {
        Tutorial() {
            const tuto = driver({
                showProgress: true,
                steps: [
                    { element: '#clocking-date', popover: { title: 'Date', description: 'Horloge / Date du jour.', side: "bottom", align: 'start'}},
                    { element: '#clocking-button', popover: { title: 'Badgage', description: 'Utilisez ce bouton pour badger en entrée ou en sortie.', side: "bottom", align: 'start'}},
                    { element: '#clocking-display', popover: { title: 'Pointage', description: 'Affichage du pointage en cours.', side: "bottom", align: 'start'}},
                    { element: '#calendar', popover: { title: 'Calendrier', description: 'Calendrier pour afficher les badges sur la semaine. Vous pouvez utiliser les flèches pour naviguer d\'une semaine à l\'autre.', side: "bottom", align: 'start'}},
                    { element: '#navbar-home', popover: { title: 'Home', description: 'Accèder à la page principale.', side: "top", align: 'start'}},
                    { element: '#navbar-dashboard', popover: { title: 'Dashboard Manager', description: 'Pour accèder à votre dashboard Manager.', side: "top", align: 'start'}},
                    { element: '#navbar-request', popover: { title: 'Demande de congés', description: 'Pour effectuer une demande de congés.', side: "top", align: 'start'}},
                    { element: '#rightbar-profile', popover: { title: 'Profil', description: 'Accèder à votre profil.', side: "left", align: 'start'}},
                    { element: '#rightbar-notif', popover: { title: 'Notifications', description: 'Accèder à vos notifications.', side: "left", align: 'start'}},
                    { element: '#rightbar-alert', popover: { title: 'Alerte', description: 'Indiquer que Batman est en mission.', side: "left", align: 'start'}},
                    { element: '#rightbar-logout', popover: { title: 'Déconnexion', description: 'Pour vous déconnecter.', side: "left", align: 'start'}},
                    
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
    justify-content: space-between;
    padding: 20px;
}

.main-content {
    flex: 1; 
    margin-right: 20px;
    margin-left: 20px;
}

.right-bar {
    width: 80px;
}
</style>