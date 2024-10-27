<template>
   <h2 class="title"> Notifications </h2>
    <div class="container-grid">
        <div class="main-notifview">      
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
.container-grid{
    height: 550px;
}
.main-notifview {
    flex: 1; 
    margin-right: 20px;
    margin-left: 20px;
}
.body-row{
    display: flex;
    justify-content: space-between;  
}
.title{
    margin: 15px;
}

</style>