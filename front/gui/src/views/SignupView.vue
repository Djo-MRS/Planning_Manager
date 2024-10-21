<template>
    <div>
        <button class="home-button" @click="goToSignin">
            <i class="fas fa-home icon">
            </i>
        </button>
        <SignupComponent />
    </div>
</template>

<script>
import SignupComponent from '@/components/SignupComponent.vue';

export default {
    name: 'SignupView',
    components: {
        SignupComponent
    },
    methods: {
      goToSignin() {
        this.$router.push('/sign_in');
      }
    }
};
</script>

<style>
    .main-content{
        padding: 50px;
    }

    .home-button {
        position: fixed;
        top: 20px;
        right: 20px;
        width: 40px;
        height: 40px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 20px;
        font-size: 24px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .home-button:hover {
        background-color: #0056b3; 
    }

    .icon {
        font-size: 20px; 
    }
</style>