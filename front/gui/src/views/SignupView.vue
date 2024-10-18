<template>
    <div>
        <SignupComponent />
    </div>
</template>

<script>
import SignupComponent from '@/components/SignupComponent.vue';

export default {
    name: 'SignupView',
    components: {
        SignupComponent
    }
};
</script>

<style>
    .main-content{
        padding: 50px;
    }
</style>