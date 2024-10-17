<template>
    <div class="main-content">
        <HomeComponent />
    </div>
</template>

<script>
import HomeComponent from '@/components/HomeComponent.vue';

export default {
    name: 'HomeView',
    components: {
        HomeComponent
    }
};
</script>

<style>
    .main-content{
        padding: 50px;
    }
</style>