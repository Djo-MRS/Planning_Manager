<template>
   <h2> Notifications </h2>
    <div class="container-grid">
        <div class="main-content">      
            <NotifListComponent />
        </div>
        <section class="right-bar">
            <RightBarComponent/>
        </section>
    <NavBarComponent />
    </div>
</template>

<script>
import NavBarComponent from '@/components/NavBarComponent.vue';
import NotifListComponent from '@/components/NotifListComponent.vue';
import RightBarComponent from '@/components/RightBarComponent.vue';


export default {
    name: 'NotificationView',
    components: {
     NotifListComponent,
     RightBarComponent,
     NavBarComponent,
    }
};
</script>

<style>
 .body-row{
        display: flex;
        justify-content: space-between;
        
    }
</style>