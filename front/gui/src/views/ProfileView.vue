<template>
  <div class="contnr-grid">
      <div >      
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
  .contnr-grid{
    display: flex;
    padding: 40px
  }

  @media (max-width: 768px) {
      .contnr-grid{
          justify-content: center;
          padding: 0px
      }
  }
</style>