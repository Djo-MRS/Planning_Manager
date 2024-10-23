<template>
    <div class="container-grid">
        <div class="main-content">      
            <WorkingTimeComponent />
        </div>
        <section class="right-bar">
            <RightBarComponent/>
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

export default {
    name: 'HomeView',
    components: {
        WorkingTimeComponent,
        RightBarComponent,
        NavBarComponent,
        AlerteBatmanComponent,
    }
};
</script>