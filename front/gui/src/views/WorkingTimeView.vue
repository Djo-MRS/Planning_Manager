<template>
    <div>
        <NavBarComponent/>
      <WorkingTimeComponent />
    </div>
</template>

<script>
import NavBarComponent from '@/components/NavBarComponent.vue';
import WorkingTimeComponent from '@/components/WorkingTimeComponent.vue';

export default {
    name: 'WorkingTimeView',
    components: {
        WorkingTimeComponent,
        NavBarComponent
    }
};
</script>