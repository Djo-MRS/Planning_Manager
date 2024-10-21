<template>
    <div>
      <h1>Account Manager</h1>
      <input v-model="user.firstName" placeholder="First Name" />
      <input v-model="user.lastName" placeholder="Last Name" />
      <input v-model="user.email" placeholder="Email" />
      <input type="password" v-model="user.password" placeholder="Password" />
      <button @click="handleUpdate">Update</button>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        user: {},
      };
    },
    mounted() {
      fetch('/api/profile')
        .then(response => response.json())
        .then(data => this.user = data);
    },
    methods: {
      handleUpdate() {
        fetch('/api/profile', {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(this.user),
        });
      },
    },
  };
  </script>
  