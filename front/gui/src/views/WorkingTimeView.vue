<template>
    <div class="container-grid">
        <div class="main-content">      
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