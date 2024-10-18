<template>
  <div>
      <ProfileComponent />
  </div>
</template>

<script>
import ProfileComponent from '@/components/ProfileComponent.vue';

export default {
  name: 'ProfileView',
  components: {
      ProfileComponent
  }
};
</script>

<style>
  .main-content{
      padding: 50px;
  }
</style>