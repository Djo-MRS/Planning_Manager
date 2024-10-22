<template>
    <div class="modify-profile">
      <h2>Modifier le profil d'un utilisateur</h2>
      <div v-if="user">
        <div class="profile-row">
          <div class="profile-item">
            <span class="profile-label">Lastname</span>
            <input type="text" class="form-input" v-model="user.lastname" />
          </div>
          <div class="profile-item">
            <span class="profile-label">Firstname</span>
            <input type="text" class="form-input" v-model="user.firstname" />
          </div>
        </div>
        <div class="profile-row">
          <div class="profile-item">
            <span class="profile-label">Email</span>
            <input type="email" class="form-input" v-model="user.email" />
          </div>
          <div class="profile-item">
            <span class="profile-label">Role</span>
            <input type="text" class="form-input" v-model="user.role" />
          </div>
        </div>
        <div class="profile-row">
          <button @click="updateUser">Mettre à jour</button>
          <button @click="deleteUser">Supprimer</button>
        </div>
      </div>
      <div v-else>
        <input type="text" v-model="searchId" placeholder="ID de l'utilisateur" />
        <button @click="fetchUser">Chercher</button>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        user: null,
        searchId: '',
      };
    },
    methods: {
      async fetchUser() {
        try {
          const token = localStorage.getItem('token');
          const response = await fetch(`/api/users/${this.searchId}`, {
            method: 'GET',
            headers: {
              'Authorization': `Bearer ${token}`,
              'Content-Type': 'application/json',
            },
          });
  
          if (response.ok) {
            this.user = await response.json();
          } else {
            console.error('Erreur lors de la récupération de l\'utilisateur:', response.statusText);
          }
        } catch (error) {
          console.error('Erreur lors de la récupération de l\'utilisateur:', error);
        }
      },
      async updateUser() {
        try {
          const token = localStorage.getItem('token');
          const response = await fetch(`/api/users/${this.user.id}`, {
            method: 'PUT',
            headers: {
              'Authorization': `Bearer ${token}`,
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(this.user),
          });
  
          if (response.ok) {
            alert('Utilisateur mis à jour avec succès !');
          } else {
            console.error('Erreur lors de la mise à jour de l\'utilisateur:', response.statusText);
          }
        } catch (error) {
          console.error('Erreur lors de la mise à jour de l\'utilisateur:', error);
        }
      },
      async deleteUser() {
        if (confirm('Êtes-vous sûr de vouloir supprimer cet utilisateur ?')) {
          try {
            const token = localStorage.getItem('token');
            const response = await fetch(`/api/users/${this.user.id}`, {
              method: 'DELETE',
              headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json',
              },
            });
  
            if (response.ok) {
              alert('Utilisateur supprimé avec succès !');
              this.user = null;
            } else {
              console.error('Erreur lors de la suppression de l\'utilisateur:', response.statusText);
            }
          } catch (error) {
            console.error('Erreur lors de la suppression de l\'utilisateur:', error);
          }
        }
      }
    }
  };
  </script>
  
  <style scoped>
  .modify-profile {
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 10px;
  }
  
  .profile-row {
    display: flex;
    margin-bottom: 15px;
  }
  
  .profile-item {
    flex: 1;
    margin-right: 10px;
  }
  
  .profile-label {
    display: block;
    margin-bottom: 5px;
  }
  
  .form-input {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
  }
  </style>
  