<template>
    <div class="container mt-5">
      <h2 class="text-center mb-4">Dashboard Manager</h2>
      <div class="row">
        <div class="col-md-6">
          <h4>Liste des équipes</h4>
          <ul class="list-group">
            <li class="list-group-item" v-for="team in teams" :key="team.id">
              {{ team.name }}
              <button
                class="btn btn-sm btn-primary float-end"
                @click="editTeam(team)"
              >
                Modifier
              </button>
            </li>
          </ul>
  
          <button class="btn btn-success mt-3" @click="showCreateForm = true">
            Créer une nouvelle équipe
          </button>
  
          <!-- Tableau des utilisateurs dans l'équipe sélectionnée (placé sous le bouton créer une nouvelle équipe) -->
          <div class="mt-4">
            <h5>Utilisateurs dans l'équipe : {{ selectedTeam ? selectedTeam.name : 'Sélectionnez une équipe' }}</h5>
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Nom</th>
                  <th>Email</th>
                  <th>Rôle</th>
                </tr>
              </thead>
              <tbody>
                <tr v-if="teamUsers.length === 0">
                  <td colspan="4" class="text-center">Aucun utilisateur dans cette équipe</td>
                </tr>
                <tr v-for="user in teamUsers" :key="user.id">
                  <td>{{ user.id }}</td>
                  <td>{{ user.firstname }} {{ user.lastname }}</td>
                  <td>{{ user.email }}</td>
                  <td>{{ user.role.name }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
  
        <div class="col-md-6">
          <h4>Actions d'équipe</h4>
  
          <!-- Formulaire de création d'équipe -->
          <div v-if="showCreateForm">
            <h5>Créer une équipe</h5>
            <form @submit.prevent="createTeam">
              <div class="mb-3">
                <label for="name" class="form-label">Nom de l'équipe</label>
                <input
                  type="text"
                  class="form-control"
                  id="name"
                  v-model="newTeam.name"
                  required
                />
              </div>
              <button type="submit" class="btn btn-success">Créer</button>
              <button class="btn btn-secondary" @click="showCreateForm = false">
                Annuler
              </button>
            </form>
          </div>
  
          <!-- Formulaire de modification d'équipe -->
          <div v-if="selectedTeam">
            <h5>Modifier l'équipe</h5>
            <form @submit.prevent="updateTeam">
              <div class="mb-3">
                <label for="editName" class="form-label">Nom de l'équipe</label>
                <input
                  type="text"
                  class="form-control"
                  id="editName"
                  v-model="selectedTeam.name"
                  required
                />
              </div>
              <button type="submit" class="btn btn-primary">Modifier</button>
              <button class="btn btn-secondary" @click="selectedTeam = null">
                Annuler
              </button>
            </form>
          </div>
  
          <!-- Ajouter un utilisateur à une équipe -->
          <div v-if="selectedTeam">
            <h5>Ajouter un utilisateur à l'équipe</h5>
            <form @submit.prevent="addUserToTeam">
              <div class="mb-3">
                <label for="userId" class="form-label">Sélectionner un utilisateur</label>
                <select class="form-control" v-model="selectedUserId" required>
                  <option v-for="user in users" :key="user.id" :value="user.id">
                    {{ user.firstname }} {{ user.lastname }} ({{ user.role.name }})
                  </option>
                </select>
              </div>
              <button type="submit" class="btn btn-success">Ajouter</button>
            </form>
          </div>
  
          <!-- Supprimer un utilisateur d'une équipe -->
          <div v-if="selectedTeam">
            <h5>Retirer un utilisateur de l'équipe</h5>
            <form @submit.prevent="removeUserFromTeam">
              <div class="mb-3">
                <label for="removeUserId" class="form-label">Sélectionner un utilisateur</label>
                <select class="form-control" v-model="selectedRemoveUserId" required>
                  <option v-for="user in users" :key="user.id" :value="user.id">
                    {{ user.firstname }} {{ user.lastname }} ({{ user.role.name }})
                  </option>
                </select>
              </div>
              <button type="submit" class="btn btn-danger">Retirer</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  
  <script>
  export default {
    data() {
      return {
        teams: [],
        users: [], // Liste des utilisateurs
        teamUsers: [], // Liste des utilisateurs d'une équipe sélectionnée
        newTeam: { name: "" },
        selectedTeam: null,
        selectedUserId: null, // Pour ajouter un utilisateur
        selectedRemoveUserId: null, // Pour retirer un utilisateur
        showCreateForm: false,
      };
    },
    created() {
      this.fetchTeams();
      this.fetchUsers(); // Récupérer la liste des utilisateurs lors de la création du composant
    },
    methods: {
      // Récupérer la liste des équipes
      fetchTeams() {
        fetch("http://localhost:4000/api/teams")
          .then((response) => response.json())
          .then((data) => {
            this.teams = data.data; // Utilise "data.data" pour obtenir la liste des équipes
            if (this.teams.length > 0) {
              // Sélectionne la première équipe par défaut
              this.selectedTeam = this.teams[0];
              this.fetchTeamUsers(this.selectedTeam.id);
            }
          })
          .catch((error) => {
            console.error("Erreur lors de la récupération des équipes:", error);
          });
      },
  
      // Récupérer la liste des utilisateurs
      fetchUsers() {
        fetch("http://localhost:4000/api/users") // Assure-toi que cette route renvoie la liste des utilisateurs
          .then((response) => response.json())
          .then((data) => {
            this.users = data.data; // Utilise "data.data" pour obtenir la liste des utilisateurs
          })
          .catch((error) => {
            console.error("Erreur lors de la récupération des utilisateurs:", error);
          });
      },
  
      // Récupérer les utilisateurs d'une équipe
      fetchTeamUsers(teamId) {
        fetch(`http://localhost:4000/api/teams/${teamId}/users`) // Assure-toi que cette route renvoie les utilisateurs d'une équipe
          .then((response) => response.json())
          .then((data) => {
            this.teamUsers = data.data; // Stocke les utilisateurs de l'équipe sélectionnée
          })
          .catch((error) => {
            console.error("Erreur lors de la récupération des utilisateurs de l'équipe:", error);
          });
      },
  
      // Sélectionner une équipe pour modification et récupérer ses utilisateurs
      editTeam(team) {
        this.selectedTeam = { ...team };
        this.fetchTeamUsers(team.id); // Récupérer les utilisateurs de l'équipe sélectionnée
      },
  
      // Créer une nouvelle équipe
      createTeam() {
        fetch("http://localhost:4000/api/teams", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ team: this.newTeam }),
        })
          .then((response) => response.json())
          .then((data) => {
            this.teams.push(data.data); // Ajoute l'équipe créée dans "this.teams"
            this.newTeam.name = "";
            this.showCreateForm = false;
          })
          .catch((error) => {
            console.error("Erreur lors de la création de l'équipe:", error);
          });
      },
  
      // Mettre à jour une équipe
      updateTeam() {
        fetch(`http://localhost:4000/api/teams/${this.selectedTeam.id}`, {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ team: this.selectedTeam }),
        })
          .then((response) => response.json())
          .then((data) => {
            const index = this.teams.findIndex((t) => t.id === this.selectedTeam.id);
            if (index !== -1) {
              this.teams[index] = data.data; // Met à jour l'équipe modifiée
            }
            this.selectedTeam = null;
          })
          .catch((error) => {
            console.error("Erreur lors de la modification de l'équipe:", error);
          });
      },
  
      // Ajouter un utilisateur à une équipe
      addUserToTeam() {
        fetch(
          `http://localhost:4000/api/teams/${this.selectedTeam.id}/add_user`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({ user_id: this.selectedUserId }),
          }
        )
          .then(() => {
            alert("Utilisateur ajouté avec succès.");
            this.selectedUserId = null;
            this.fetchTeamUsers(this.selectedTeam.id); // Rafraîchit la liste des utilisateurs de l'équipe
          })
          .catch((error) => {
            console.error("Erreur lors de l'ajout de l'utilisateur à l'équipe:", error);
          });
      },
  
      // Retirer un utilisateur d'une équipe
      removeUserFromTeam() {
        fetch(
          `http://localhost:4000/api/teams/${this.selectedTeam.id}/remove_user`,
          {
            method: "DELETE",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({ user_id: this.selectedRemoveUserId }),
          }
        )
          .then(() => {
            alert("Utilisateur retiré avec succès.");
            this.selectedRemoveUserId = null;
            this.fetchTeamUsers(this.selectedTeam.id); // Rafraîchit la liste des utilisateurs de l'équipe
          })
          .catch((error) => {
            console.error("Erreur lors du retrait de l'utilisateur de l'équipe:", error);
          });
      },
    },
  };
  </script>
  
  <style scoped>
  h2 {
    color: #2c3e50;
  }
  
  button {
    margin-right: 10px;
  }
  </style>
  