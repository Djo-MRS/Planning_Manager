<template>
    <div>
      <button class="signup-button" @click="goToSignup">+</button>
      <LoginComponent />
    </div>
  </template>
  
  <script>
  import LoginComponent from '@/components/LoginComponent.vue';
  
  export default {
    name: 'LoginView',
    components: {
      LoginComponent
    },
    methods: {
      goToSignup() {
        
        this.$router.push('/sign_up');
      }
    }
  };
  </script>
  
<style>
    .main-content{
        padding: 50px;
    }

    .signup-button {
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
        z-index: 1000; 
    }
  
    .signup-button:hover {
        background-color: #0056b3; 
    }
</style>