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