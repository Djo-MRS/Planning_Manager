<template>
    <h2> Mes demandes </h2>
    <div class="body-row">
        <RequestFormComponent/>
        <RequestListComponent/>
    </div>
</template>

<script>
import RequestFormComponent from '@/components/RequestFormComponent.vue';
import RequestListComponent from '@/components/RequestListComponent.vue';


export default {
    name: 'RequestView',
    components: {
        RequestFormComponent,
        RequestListComponent
    }
};
</script>

<style>

    .body-row{
        display: flex;
        justify-content: space-between;
        
    }
</style>