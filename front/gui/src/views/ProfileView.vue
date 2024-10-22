<template>
  <div class="container-grid">
      <div class="main-content">      
          <ProfileComponent />
      </div>
      <section class="right-bar">
          <RightBarComponent/>
      </section>
      <NavBarComponent />
  </div>
</template>

<script>
import NavBarComponent from '@/components/NavBarComponent.vue';
import ProfileComponent from '@/components/ProfileComponent.vue';
import RightBarComponent from '@/components/RightBarComponent.vue';

export default {
  name: 'ProfileView',
  components: {
    ProfileComponent,
    NavBarComponent,
    RightBarComponent,
  }
};
</script>

<style>
  .main-content{
      padding: 50px;
  }
</style>