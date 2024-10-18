<template>
    <div>
        <LoginComponent />
    </div>
</template>

<script>
import LoginComponent from '@/components/LoginComponent.vue';

export default {
    name: 'LoginView',
    components: {
        LoginComponent
    }
};
</script>

<style>
    .main-content{
        padding: 50px;
    }
</style>