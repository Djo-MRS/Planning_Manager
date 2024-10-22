<template>
  <main class="profile-view">
    <div class="profile-container">
      <div class="profile-content">
        <section class="profile-info">
          <div class="profile-details">
            <h1 class="profile-title">Management</h1>
            <button v-if="isAdmin" @click="showSignup">+</button>
            <SignupComponent v-if="showSignupForm" @close="showSignupForm = false" />
          </div>
        </section>
      </div>
    </div>
  </main>
</template>

<script>
import SignupComponent from '@/components/SignupComponent.vue';

export default {
  name: 'ManagerComponent',
  components: {
    SignupComponent,
  },
  data() {
    return {
      showSignupForm: false,
    };
  },
  computed: {
    isAdmin() {
      return localStorage.getItem('roleId') === 'admin';
    },
  },
  methods: {
    showSignup() {
      this.showSignupForm = true; // Affichez le formulaire d'inscription
    },
  },
};
</script>

<style scoped>
.profile-view {
    background-color: #fff;
    display: flex;
    flex-direction: column;
    overflow: hidden;
    padding: 20px 30px; 
    width: 1000px;
  }
  
  .profile-container {
    width: 739px;
    max-width: 100%;
  }
  
  .profile-content {
    display: flex;
    gap: 20px;
  }
  
  .profile-info {
    width: 35%;
  }
  
  .profile-details {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    color: #000;
    font: 400 20px Inter, sans-serif;
  }
  
  .profile-title {
    text-shadow: 0 4px 4px rgba(0, 0, 0, 0.25);
    font-size: 30px;
    align-self: flex-start;
  }
  
  .profile-row {
    display: flex;
    align-items: center;
    margin-top: 20px;
  }
  
  .profile-item {
    display: flex;
    align-items: right;
    gap: 10px;
    width: 200px; 
  }
  
  .profile-icon {
    object-fit: contain;
    width: 40px;
  }
  
  .profile-label {
    margin: auto 0;
  }
  
  .form-input {
    border-radius: 10px;
    background-color: #fff;
    box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25);
    height: 45px; 
    border: 1px solid #8d8d8d;
    width: 400px;
  }
  
  @media (max-width: 991px) {
    .profile-view {
      padding: 0 20px;
    }
  
    .profile-content {
      flex-direction: column;
    }
  
    .profile-info {
      width: 100%;
      margin-left: 0;
    }
  
    .profile-details {
      margin-top: 35px;
    }
  
    .form-input {
      margin-bottom: 40px;
      width: 100%; 
    }
  }
</style>
