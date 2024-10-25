<template>
    <div class="container-grid">
        <div class="main-content">      
            <SignupComponent />
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
import SignupComponent from '@/components/SignupComponent.vue';

export default {
    name: 'SignupView',
    components: {
        SignupComponent,
        RightBarComponent,
        AlerteBatmanComponent,
        NavBarComponent
    },
    methods: {
      goToSignin() {
        this.$router.push('/sign_in');
      }
    }
};
</script>

<style>
    

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