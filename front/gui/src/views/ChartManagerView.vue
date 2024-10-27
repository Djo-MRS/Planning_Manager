<template>
    <div class="container-grid">
        <div class="main-content">    
            <ChartManagerComponent />  
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
import ChartManagerComponent from '@/components/ChartManagerComponent.vue';


export default {
    name: 'TeamsView',
    components: {
        RightBarComponent,
        NavBarComponent,
        ChartManagerComponent
    }
};
</script>