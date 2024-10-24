<template>
    <div v-if="alertVisible" class="alert">
      BATMAN EST EN MISSION !!!
    </div>
  </template>
  
  <script>
  export default {
    name: 'AlerteBatmanComponent',
    data() {
      return {
        alertVisible: false,
      };
    },
    methods: {
      showAlert() {
        this.alertVisible = true;
        setTimeout(() => {
          this.alertVisible = false; 
        }, 3000);
      },
      getStatus() {
        return this.alertVisible;
      }
    },
  }
  </script>
  
  <style>
  .alert {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: rgba(255, 0, 0, 0.8);
    color: white;
    font-size: 36px;
    padding: 20px;
    border-radius: 10px;
    z-index: 1000;
  }
  </style>
  