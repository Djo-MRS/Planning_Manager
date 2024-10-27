<template>
    <main class="profile-view">
        <h1 class="profile-title">Management</h1>
        <div class="">
            <div class="buttons">
                <MDBBtn color="info" class="add-task-button" id="dashboard-task" @click="openModal">Ajouter une tâche</MDBBtn>
                <MDBBtn color="warning" class="add-task-button" id="dashboard-addteam" @click="goToPage('/teams')">Planning des équipes</MDBBtn>
            </div>
            <ManagerModalComponent :showModal="isModalOpen" :currentDate="currentDate" :users="users" :from="add" @closeModal="closeModal" />
        </div>
        <div class="header">
            <button @click="prevWeek" class="arrow-button">&larr;</button>
            <h2 class="week-title">{{ weekTitle }}</h2>
            <button @click="nextWeek" class="arrow-button">&rarr;</button>
        </div>
            <div class="calendar" id="calendar-team">
                <div class="tab-col-users">
                    <div class="users-col">
                        <select v-model="selectedTeam" @change="selectTeam" id="dashboard-team">
                            <option v-for="team in teamsManager" :key="team.id" :value="team.teamName">
                                {{ team.teamName }}
                            </option>
                        </select>
                        <div class="users-cell" v-for="user in users" :key="user.firstname">
                            <div class="image-profile"></div>
                            {{ user.firstname }}
                        </div>
                    </div>
                </div>
                <div class="tab-col-week">
                    <div class="days">
                        <div class="day-cell" v-for="(day, index) in weekDays" :key="index">
                            {{ formatDate(day) }}
                        </div>
                    </div>
                    <div class="calendar-table">
                        <div class="users">
                            <div v-for="(user, userIndex) in users" :key="userIndex" class="user-row">
                                <div class="event-cells">
                                    <div v-for="(day, dayIndex) in weekDays" :key="dayIndex" class="event-cell">
                                        <div class="event-part upper-part">
                                            <TaskItemComponent 
                                                v-for="task in getTasksForDay(day, user)" 
                                                :key="task.start" 
                                                :task="task" 
                                                :type="wt"
                                                :current_user="user"
                                            />
                                        </div>
                                        <div class="event-part lower-part"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </main>
</template>

<script>
import { MDBBtn } from 'mdb-vue-ui-kit';
import TaskItemComponent from './TaskItemComponent.vue';
import { ref } from 'vue';
import ManagerModalComponent from './ManagerModalComponent.vue';

export default {
    data() {
        return {
            wt: "workingtime",
            isModalOpen: false,
            teamManager: false,
            currentTask: {},
            add: "add",
            tasks: [
                {
                    user: 'Alice', // Assignation à l'utilisateur
                    title: 'Réunion de projet',
                    start: '2024-10-25T09:00:00', // Date et heure de début
                    end: '2024-10-25T10:00:00' // Date et heure de fin
                },
                {
                    user: 'Bob',
                    title: 'Développement des fonctionnalités',
                    start: '2024-10-24T14:00:00',
                    end: '2024-10-24T16:00:00'
                }
            ],
            selectedTeam: ref('Policier'),
            teamsManager: [
                { id: 1, teamName: "Policier" },
                { id: 2, teamName: "Comptabilité" },
                { id: 3, teamName: "Commerciale" },
            ],
            teamUsers:[],
            currentDate: ref(new Date()),
            users: [
                { firstname: 'Alice', profilePic: 'https://via.placeholder.com/40' },
                { firstname: 'Bob', profilePic: 'https://via.placeholder.com/40' },
                { firstname: 'Charlie', profilePic: 'https://via.placeholder.com/40' },
                { firstname: 'Angelina', profilePic: 'https://via.placeholder.com/40' },
                { firstname: 'Angelina', profilePic: 'https://via.placeholder.com/40' },
                { firstname: 'Angelina', profilePic: 'https://via.placeholder.com/40' },
                { firstname: 'Angelina', profilePic: 'https://via.placeholder.com/40' },
                { firstname: 'Angelina', profilePic: 'https://via.placeholder.com/40' },
                { firstname: 'Angelina', profilePic: 'https://via.placeholder.com/40' },
            ],
          
            
            
        };
    },
    components: {
        MDBBtn,
        TaskItemComponent,
        ManagerModalComponent
    },
    computed: {
        weekTitle() {
            const startOfWeek = this.getStartOfWeek(this.currentDate);
            const endOfWeek = new Date(startOfWeek);
            endOfWeek.setDate(endOfWeek.getDate() + 6);
            return `Semaine du ${startOfWeek.toLocaleDateString()} au ${endOfWeek.toLocaleDateString()}`;
        },
        weekDays() {
            const days = [];
            const startOfWeek = this.getStartOfWeek(this.currentDate);

            for (let i = 0; i < 7; i++) {
                const day = new Date(startOfWeek);
                day.setDate(day.getDate() + i);
                days.push(day);  
            }
            return days;
        }
    },
    
    methods: {
        getStartOfWeek(date) {
            const startOfWeek = new Date(date);
            startOfWeek.setDate(startOfWeek.getDate() - (startOfWeek.getDay() === 0 ? 6 : startOfWeek.getDay() - 1));
            return startOfWeek;
        },
        prevWeek() {
            this.currentDate.setDate(this.currentDate.getDate() - 7);
        },
        nextWeek() {
            this.currentDate.setDate(this.currentDate.getDate() + 7);
        },
        openModal() {
            this.isModalOpen = true;
        },
        closeModal() {
            console.log('ici')
            this.isModalOpen = false;
        },
       
        selectTeam() {
            this.fetchUsersByTeam(this.selectedTeam.id);
        },
        addTasks(task){
            this.tasks.push(task);
        },
        handleClick(){

        },
        getTasksForDay(day, user) {
            const dayDate = new Date(day).toDateString();
            
            return this.tasks.filter(task => {
                if (!task || !task.start) {
                    
                    return false;
                }
                const taskDate = new Date(task.start).toDateString();
                return taskDate === dayDate && task.user === user.firstname;
            });
        },
        formatDate(date) {
        // Formater la date en français
            return date.toLocaleDateString('fr-FR', {
                weekday: 'long',  // Affiche le jour de la semaine (ex: "mercredi")
                day: 'numeric',   // Affiche le jour du mois (ex: "23")
                month: 'long'     // Affiche le mois (ex: "octobre")
            });
        },

        goToPage(path) {
            this.$router.push(path);
        },
        
        async fetchTeamsByManager() {
            console.log('okok')
            try {
                const response = await fetch(
                    `http://localhost:4000/api/teams/manager`,
                    {
                        method: "GET",
                        headers: {
                            "Content-Type": "application/json",
                        },
                    }
                );
                if (!response.ok) {
                    if (response.status === 404) {
                        throw new Error("Erreur lors de la récupération de l'état de pointage");
                    }
                }

                const result = await response.json();
                this.teamUsers = result.data;

            } catch (error) {
                console.error("Erreur lors de la récupération de l'état de pointage", error);
                this.errorMessage = `Erreur : ${error.message}`;
            }
        },
        async fetchUsersByTeam(teamId) {
            console.log('okokkk')
            try {
                const response = await fetch(
                    `http://localhost:4000/api/teams/users?teamId=${teamId}`,
                    {
                        method: "GET",
                        headers: {
                            "Content-Type": "application/json",
                        },
                    }
                );
                if (!response.ok) {
                    if (response.status === 404) {
                        throw new Error("Erreur lors de la récupération de l'état de pointage");
                    }
                }

                const result = await response.json();
                this.users = result.data;

            } catch (error) {
                console.error("Erreur lors de la récupération de l'état de pointage", error);
                this.errorMessage = `Erreur : ${error.message}`;
            }
        },

    },
    mounted() {
        console.log(this.teamsManager[0].teamName)
        this.selected = this.teamsManager[0].teamName;
     
    }
};

</script>
  
  <style scoped>
.calendar {
    display: flex;
    align-items: center;
    justify-content: center; 
    margin: 0px;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
    background-color: #fff;
    max-height: 450px;
    overflow: auto;
    flex-wrap: nowrap; /* Permet aux éléments de passer à la ligne si nécessaire */
}

.header {
    display: flex;
    align-items: center;
    justify-content: center; 
    width: 100%;
    margin-bottom: 10px;
}

.arrow-button {
    background: none;
    border: none;
    font-size: 24px; 
    cursor: pointer;
    color: #007BFF;
    transition: color 0.3s;
    margin: 0 5px; 
}

.arrow-button:hover {
    color: #0056b3; 
}

.week-title { 
    font-size: 20px; 
    font-weight: bold;
    color: #333; 
}

.calendar-table {
    display: flex;
    flex-direction: row;
    background-color: #8d8d8d;
    justify-content: center; 
    flex-wrap: wrap; /* Permet aux colonnes de se réorganiser sur petits écrans */
}

.days {
    display: flex;
    flex-direction: row; 
    flex-wrap: wrap; /* Permet aux jours de se réorganiser */
}

.day-cell {
    text-align: center;
    width: 100px; /* Peut être ajusté pour les écrans plus petits */
    background-color: #f9f9f9; 
    padding: 10px;
    margin-left: 1px;
}

.users {
    display: flex;
    flex-direction: column; 
    width: 100%;
}

.user-row {
    display: flex;
    align-items: center;
    flex-wrap: nowrap; /* Permet aux utilisateurs de se réorganiser */
}

.event-cells {
    display: flex;
    flex-wrap: wrap; /* Permet aux événements de se réorganiser */
}

.event-cell {
    display: flex;
    flex-direction: column; 
    width: 100px; /* Ajuste cette largeur pour plus de flexibilité */
    height: 100px; 
    border-top: 1px solid #ccc; 
    margin-left: 1px; 
    background-color: #e9ecef; 
}

.event-part {
    flex: 1; 
    display: flex;
    justify-content: center; 
    align-items: center; 
    cursor: pointer; 
}

.title-cell {
    padding: 10px;
    width: 100px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.users-cell {
    height: 100px;
    width: 100px;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

.image-profile {
    border: #8d8d8d solid 1px;
    border-radius: 50px;
    height: 70px;
    width: 70px;
}

.add-task-button {
    margin: 10px;
}

select {
    height: 72px;
    width: 100%;
    border: 1px #8D8D8D solid;
}

/* Media Queries */
@media (max-width: 768px) {
    .day-cell {
        width: 80px; 
    }

    .event-cell {
        width: 80px; 
        height: auto; 
    }

    .week-title {
        font-size: 18px; 
    }

    .arrow-button {
        font-size: 20px; 
    }

    .users-cell {
        width: 80px; 
    }
}
</style>
