<template>
    <div class="container-grid">
        <div class="main-container">      
            <WorkingTimeComponent />
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
import WorkingTimeComponent from '@/components/WorkingTimeComponent.vue';

export default {
    name: 'WorkingTimeView',
    components: {
        WorkingTimeComponent,
        RightBarComponent,
        NavBarComponent,
    }
};
</script>

<style>
    .container-grid{
        display: flex;
        justify-content: center;
        height: 100vh;
        position: relative;
    }
    .main-container{
        padding: 0px;
    }
</style>