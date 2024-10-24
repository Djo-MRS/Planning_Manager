<template>
    <div class="container-grid">
        <div class="main-content">    
            <TeamsComponent />  
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
import TeamsComponent from '@/components/TeamsComponent.vue';


export default {
    name: 'TeamsView',
    components: {
        RightBarComponent,
        NavBarComponent,
        TeamsComponent
    }
};
</script>