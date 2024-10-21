<template>
    <div>
        <HelpComponent />
    </div>
</template>

<script>
import HelpComponent from '@/components/HelpComponent.vue';

export default {
    name: 'HelpView',
    components: {
        HelpComponent
    }
};
</script>

<style>
    .main-content{
        padding: 50px;
    }
</style>