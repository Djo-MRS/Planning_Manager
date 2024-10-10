<template>
    <NavBarComponent />
    <HomeView />
</template>

<script>
import NavBarComponent from './components/NavBarComponent.vue';
import HomeView from './views/HomeView.vue';

export default {
    name: 'App',
    components: {
        HomeView,
        NavBarComponent
    }
};
</script>

<style>
</style>