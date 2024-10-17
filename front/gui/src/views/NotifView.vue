<template>
   <h2> Notifications </h2>
    <div class="body-row">
        
        <NotifListComponent/>
    </div>
</template>

<script>
import NotifListComponent from '@/components/NotifListComponent.vue';


export default {
    name: 'NotificationView',
    components: {
     NotifListComponent
    }
};
</script>

<style>
 .body-row{
        display: flex;
        justify-content: space-between;
        
    }
</style>