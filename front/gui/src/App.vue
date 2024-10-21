<template>
  <div>
    <router-view />
  </div>
 </template>
  
<script>
export default {
  name: 'App',
  computed: {
    isAuthenticated() {
      return !!localStorage.getItem('userId');
    },
  },
  methods: {
    logout() {
      localStorage.removeItem('xsrfToken');
      localStorage.removeItem('userId');
      localStorage.removeItem('roleId');
      this.$router.push('/sign_in');
    },
  },
};
</script>
  
  <style>
  .container-grid {
    display: flex;
    justify-content: space-between;
    height: 100vh;
    position: relative;
  }
  .main-content {
    flex-grow: 1;
  }
  .right-bar {
    position: fixed;
    right: 0;
    top: 0;
    height: 100%;
    width: 100px;
  }
  body {
    margin: 0;
    padding: 0;
    overflow: hidden;
  }
  nav {
    position: fixed;
    bottom: 0;
    width: 100%;
    z-index: 10; 
  }
  </style>
  