<template>
  <main class="profile-view">
    <div class="profile-container">
      <div class="profile-content">
        <section class="profile-info">
          <div class="profile-details">
            <h1 class="profile-title">Management</h1>
            <div>
            </div>
          </div>
        </section>
      </div>
    </div>
    <ManagerCalendarComponent/>
  </main>
</template>

<script>
//import ModifyProfileComponent from '@/components/ModifyProfileComponent.vue';
import ManagerCalendarComponent from './ManagerCalendarComponent.vue';

export default {
  name: 'ManagerComponent',
  components: {
    ManagerCalendarComponent,
  },
  /*data() {
    return {
      showModifyForm: false,
    };
  },
  computed: {
    isAdmin() {
      return localStorage.getItem('roleId') === 'admin';
    },
  },
  methods: {
    showModifyProfile() {
      this.showModifyForm = true;
    },
  },*/
};
</script>

<style scoped>
.profile-view {
  display: flex;
  flex-direction: column; 
  height: 100vh; 
  overflow: hidden; 
}

.profile-container {
  flex: 1; 
  display: flex;
  align-items: flex-start; 
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
    margin: 0;
  }
  
  .profile-row {
    display: flex;
    align-items: center;
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

  .manager-calendar {
  overflow-y: auto; 
  flex: 1; 
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
