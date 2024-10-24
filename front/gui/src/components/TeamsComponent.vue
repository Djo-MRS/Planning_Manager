<template>
  <div class="container-fluid p-4 bg-light">
    <header class="d-flex justify-content-between align-items-center mb-4">
      <h2 class="text-primary font-weight-bold">Dashboard Manager</h2>
      <button class="btn btn-success" @click="showCreateForm = true">
        + Créer une nouvelle équipe
      </button>
    </header>

    <div class="row g-4">
      <!-- Carousel pour les petits écrans -->
      <div class="col-12 d-md-none">
        <div id="cardsCarousel" class="carousel slide" data-bs-ride="carousel">
          <div class="carousel-inner">
            <!-- Slide 1: Liste des équipes (Aside) -->
            <div class="carousel-item active">
              <aside class="bg-white shadow-sm rounded p-3">
                <h4 class="text-secondary mb-3">Liste des équipes</h4>
                <ul class="list-group">
                  <li
                    v-for="team in teams"
                    :key="team.id"
                    class="list-group-item d-flex justify-content-between align-items-center mb-2"
                  >
                    <span>{{ team.name }}</span>
                    <button class="btn btn-outline-primary btn-sm" @click="editTeam(team)">
                      Modifier
                    </button>
                  </li>
                </ul>
              </aside>
            </div>
            <!-- Slide 2: Actions d'équipe -->
            <div class="carousel-item">
              <section>
                <div class="card h-100 shadow-sm">
                  <div class="card-body">
                    <h4 class="card-title text-secondary mb-3">Actions d'équipe</h4>

                    <!-- Formulaire de création d'équipe -->
                    <div v-if="showCreateForm" class="mb-4">
                      <h5>Créer une équipe</h5>
                      <form @submit.prevent="createTeam">
                        <div class="mb-3">
                          <label for="name" class="form-label">Nom de l'équipe</label>
                          <input type="text" class="form-control" id="name" v-model="newTeam.name" required />
                        </div>
                        <button type="submit" class="btn btn-success me-2">Créer</button>
                        <button class="btn btn-outline-secondary" @click="showCreateForm = false">Annuler</button>
                      </form>
                    </div>

                    <!-- Formulaire de modification d'équipe -->
                    <div v-if="selectedTeam" class="mb-4">
                      <h5>Modifier l'équipe</h5>
                      <form @submit.prevent="updateTeam">
                        <div class="mb-3">
                          <label for="editName" class="form-label">Nom de l'équipe</label>
                          <input
                            type="text"
                            class="form-control"
                            id="editName"
                            v-model="selectedTeam.name"
                            @input="updateTeamNameInList"
                            required
                          />
                        </div>
                        <button type="submit" class="btn btn-primary me-2">Modifier</button>
                        <button class="btn btn-outline-secondary" @click="selectedTeam = null">Annuler</button>
                      </form>
                    </div>

                    <!-- Ajouter un utilisateur à une équipe -->
                    <div v-if="selectedTeam" class="mt-4 mb-4">
                      <h5>Ajouter un utilisateur à l'équipe</h5>
                      <form @submit.prevent="addUserToTeam">
                        <div class="mb-3">
                          <label for="userId" class="form-label">Sélectionner un utilisateur</label>
                          <select class="form-select" v-model="selectedUserId" required>
                            <option v-for="user in users" :key="user.id" :value="user.id">
                              {{ user.firstname }} {{ user.lastname }} ({{ user.role.name }})
                            </option>
                          </select>
                        </div>
                        <button type="submit" class="btn btn-success">Ajouter</button>
                      </form>
                    </div>

                    <!-- Supprimer un utilisateur d'une équipe -->
                    <div v-if="selectedTeam" class="mt-4 mb-4">
                      <h5>Retirer un utilisateur de l'équipe</h5>
                      <form @submit.prevent="removeUserFromTeam">
                        <div class="mb-3">
                          <label for="removeUserId" class="form-label">Sélectionner un utilisateur</label>
                          <select class="form-select" v-model="selectedRemoveUserId" required>
                            <option v-for="user in teamUsers" :key="user.id" :value="user.id">
                              {{ user.firstname }} {{ user.lastname }} ({{ user.role.name }})
                            </option>
                          </select>
                        </div>
                        <button type="submit" class="btn btn-danger">Retirer</button>
                      </form>
                    </div>
                  </div>
                </div>
              </section>
            </div>
            <!-- Slide 3: Tableau des utilisateurs -->
            <div class="carousel-item">
              <section>
                <div class="card h-100 shadow-sm">
                  <div class="card-body">
                    <h5 class="card-title mb-4">Utilisateurs dans l'équipe : {{ selectedTeam ? selectedTeam.name : 'Sélectionnez une équipe' }}</h5>
                    <table class="table table-striped table-hover">
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
              </section>
            </div>
          </div>
          <!-- Contrôles du carousel -->
          <button
            class="carousel-control-prev"
            type="button"
            data-bs-target="#cardsCarousel"
            data-bs-slide="prev"
          >
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Précédent</span>
          </button>
          <button
            class="carousel-control-next"
            type="button"
            data-bs-target="#cardsCarousel"
            data-bs-slide="next"
          >
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Suivant</span>
          </button>
        </div>
      </div>

      <!-- Affichage normal pour les écrans moyens et grands -->
      <aside class="col-md-3 d-none d-md-block">
        <div class="bg-white shadow-sm rounded p-3 overflow-auto">
          <h4 class="text-secondary mb-3">Liste des équipes</h4>
          <ul class="list-group">
            <li
              v-for="team in teams"
              :key="team.id"
              class="list-group-item d-flex justify-content-between align-items-center mb-2"
            >
              <span>{{ team.name }}</span>
              <button class="btn btn-outline-primary btn-sm" @click="editTeam(team)">
                Modifier
              </button>
            </li>
          </ul>
        </div>
      </aside>
      <main class="col-md-9 d-none d-md-block">
        <div class="row g-4">
          <!-- Actions d'équipe -->
          <section class="col-md-6">
            <div class="card h-100 shadow-sm">
              <div class="card-body">
                <h4 class="card-title text-secondary mb-3">Actions d'équipe</h4>

                <!-- Formulaire de création d'équipe -->
                <div v-if="showCreateForm" class="mb-4">
                  <h5>Créer une équipe</h5>
                  <form @submit.prevent="createTeam">
                    <div class="mb-3">
                      <label for="name" class="form-label">Nom de l'équipe</label>
                      <input type="text" class="form-control" id="name" v-model="newTeam.name" required />
                    </div>
                    <button type="submit" class="btn btn-success me-2">Créer</button>
                    <button class="btn btn-outline-secondary" @click="showCreateForm = false">Annuler</button>
                  </form>
                </div>

                <!-- Formulaire de modification d'équipe -->
                <div v-if="selectedTeam" class="mb-4">
                  <h5>Modifier l'équipe</h5>
                  <form @submit.prevent="updateTeam">
                    <div class="mb-3">
                      <label for="editName" class="form-label">Nom de l'équipe</label>
                      <input
                        type="text"
                        class="form-control"
                        id="editName"
                        v-model="selectedTeam.name"
                        @input="updateTeamNameInList"
                        required
                      />
                    </div>
                    <button type="submit" class="btn btn-primary me-2">Modifier</button>
                    <button class="btn btn-outline-secondary" @click="selectedTeam = null">Annuler</button>
                  </form>
                </div>

                <!-- Ajouter un utilisateur à une équipe -->
                <div v-if="selectedTeam" class="mt-4 mb-4">
                  <h5>Ajouter un utilisateur à l'équipe</h5>
                  <form @submit.prevent="addUserToTeam">
                    <div class="mb-3">
                      <label for="userId" class="form-label">Sélectionner un utilisateur</label>
                      <select class="form-select" v-model="selectedUserId" required>
                        <option v-for="user in users" :key="user.id" :value="user.id">
                          {{ user.firstname }} {{ user.lastname }} ({{ user.role.name }})
                        </option>
                      </select>
                    </div>
                    <button type="submit" class="btn btn-success">Ajouter</button>
                  </form>
                </div>

                <!-- Supprimer un utilisateur d'une équipe -->
                <div v-if="selectedTeam" class="mt-4 mb-4">
                  <h5>Retirer un utilisateur de l'équipe</h5>
                  <form @submit.prevent="removeUserFromTeam">
                    <div class="mb-3">
                      <label for="removeUserId" class="form-label">Sélectionner un utilisateur</label>
                      <select class="form-select" v-model="selectedRemoveUserId" required>
                        <option v-for="user in teamUsers" :key="user.id" :value="user.id">
                          {{ user.firstname }} {{ user.lastname }} ({{ user.role.name }})
                        </option>
                      </select>
                    </div>
                    <button type="submit" class="btn btn-danger">Retirer</button>
                  </form>
                </div>
              </div>
            </div>
          </section>

          <!-- Tableau des utilisateurs dans l'équipe sélectionnée -->
          <section class="col-md-6">
            <div class="card h-100 shadow-sm">
              <div class="card-body">
                <h5 class="card-title mb-4">Utilisateurs dans l'équipe : {{ selectedTeam ? selectedTeam.name : 'Sélectionnez une équipe' }}</h5>
                <table class="table table-striped table-hover">
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
          </section>
        </div>
      </main>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      teams: [],
      users: [],
      teamUsers: [],
      newTeam: { name: "" },
      selectedTeam: null,
      selectedUserId: null,
      selectedRemoveUserId: null,
      showCreateForm: false,
    };
  },
  created() {
    this.fetchTeams();
    this.fetchUsers();
  },
  methods: {
    fetchTeams() {
      fetch("http://localhost:4000/api/teams")
        .then((response) => response.json())
        .then((data) => {
          this.teams = data.data;
          this.selectedTeam = null;
          this.teamUsers = [];
        })
        .catch((error) => {
          console.error("Erreur lors de la récupération des équipes:", error);
        });
    },
    fetchUsers() {
      fetch("http://localhost:4000/api/users")
        .then((response) => response.json())
        .then((data) => {
          this.users = data.data;
        })
        .catch((error) => {
          console.error("Erreur lors de la récupération des utilisateurs:", error);
        });
    },
    fetchTeamUsers(teamId) {
      fetch(`http://localhost:4000/api/teams/${teamId}/users`)
        .then((response) => response.json())
        .then((data) => {
          this.teamUsers = data.data;
        })
        .catch((error) => {
          console.error("Erreur lors de la récupération des utilisateurs de l'équipe:", error);
        });
    },
    editTeam(team) {
      this.selectedTeam = { ...team };
      this.fetchTeamUsers(team.id);
    },
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
          this.teams.push(data.data);
          this.newTeam.name = "";
          this.showCreateForm = false;
        })
        .catch((error) => {
          console.error("Erreur lors de la création de l'équipe:", error);
        });
    },
    updateTeamNameInList() {
      const team = this.teams.find((t) => t.id === this.selectedTeam.id);
      if (team) {
        team.name = this.selectedTeam.name;
      }
    },
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
            this.teams[index] = data.data;
          }
          this.selectedTeam = null;
        })
        .catch((error) => {
          console.error("Erreur lors de la modification de l'équipe:", error);
        });
    },
    addUserToTeam() {
      fetch(`http://localhost:4000/api/teams/${this.selectedTeam.id}/add_user`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ user_id: this.selectedUserId }),
      })
        .then(() => {
          alert("Utilisateur ajouté avec succès.");
          this.selectedUserId = null;
          this.fetchTeamUsers(this.selectedTeam.id);
        })
        .catch((error) => {
          console.error("Erreur lors de l'ajout de l'utilisateur à l'équipe:", error);
        });
    },
    removeUserFromTeam() {
      fetch(`http://localhost:4000/api/teams/${this.selectedTeam.id}/remove_user`, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ user_id: this.selectedRemoveUserId }),
      })
        .then(() => {
          alert("Utilisateur retiré avec succès.");
          this.selectedRemoveUserId = null;
          this.fetchTeamUsers(this.selectedTeam.id);
        })
        .catch((error) => {
          console.error("Erreur lors du retrait de l'utilisateur de l'équipe:", error);
        });
    },
  },
};
</script>

<style scoped>
body {
  background-color: #f8f9fa;
}

.card {
  border-radius: 0.5rem;
}

.card-title {
  font-size: 1.25rem;
  font-weight: bold;
}

.list-group-item {
  border-radius: 0.5rem;
}

.form-label {
  font-weight: 500;
}

/* Styles spécifiques pour les petits écrans */
@media (max-width: 768px) {
  .carousel-item {
    padding: 15px;
  }

  .card,
  aside {
    margin-bottom: 20px;
  }
}
</style>

