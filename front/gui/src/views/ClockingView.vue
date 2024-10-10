<template>
    <div>
      <NavBarComponent />
      <ClockingComponent />
    </div>
  </template>
  
  <script>
  import NavBarComponent from '@/components/NavBarComponent.vue';
  import ClockingComponent from '@/components/ClockingComponent.vue';
  
  export default {
    name: "ClockingView",
    components: {
      NavBarComponent,
      ClockingComponent,
    },
  };
  </script>
  
