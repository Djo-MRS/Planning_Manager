<template>
    <div class="column">
        <div class="top-column">
            <MDBBtn color="light" floating class="profile-button" @click="goToPage('/profile')">
                <MDBIcon icon="user" style="font-size: 25px;"></MDBIcon>
            </MDBBtn>
            <MDBBtn color="light" floating class="notif-button" @click="goToPage('/notif')">
                <MDBIcon icon="bell" style="font-size: 18px;"></MDBIcon>
            </MDBBtn>
            <MDBBtn color="light" floating class="notif-button" @click="goToSignup" v-if="isAdmin">
                <MDBIcon icon="user-cog" style="font-size: 18px;"></MDBIcon>
            </MDBBtn> 
        </div>
        <div class="center-button">
            <MDBBtn color="light" floating class="notif-button" @click="triggerAlert">
                <i class="fab fa-earlybirds" style="font-size: 40px;"></i>
            </MDBBtn>
        </div>
        <MDBBtn color="light" floating class="notif-button" @click="goToPage('/help')">
            <MDBIcon icon="question" style="font-size: 18px;"></MDBIcon>
        </MDBBtn>
        <MDBBtn color="light" floating class="notif-button" @click="goToLogout">
            <MDBIcon icon="sign-out-alt" style="font-size: 18px;"></MDBIcon>
        </MDBBtn>
        <div v-if="alertVisible" class="alert">
            BATMAN EST EN MISSION !!!
        </div>
    </div>
</template>

<script>
import { MDBBtn, MDBIcon } from "mdb-vue-ui-kit";

export default {
    name: "RightBarComponent",
    components: {
        MDBBtn,
        MDBIcon
    },
    data() {
        return {
            alertVisible: false,
            isAdmin: false
        };
    },
    mounted() {
        if (JSON.parse(localStorage.getItem('user')).role === 'admin') {
            this.isAdmin = true;
        } else {
            this.isAdmin = false;
        }
    },
    methods: {
        goToSignup() {
            this.$router.push('/sign_up');
        },
        goToPage(path) {
            this.$router.push(path);
        },
        triggerAlert() {
            this.$refs.alerte.showAlert();
        },
        goToLogout() {
            localStorage.clear();
            this.$router.push('/sign_in');
        },
        async sendNotification() {
            const userRole = this.getUserRole();
            if (userRole === 'Manager' || userRole === 'Admin') {
                try {
                    const response = await fetch('/api/notifications', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            notification: {
                                title: "Mission Alert",
                                message: "Batman est en mission !!!",
                                date: new Date().toISOString(),
                                sender: "System",
                                receiver: "User"
                            }
                        })
                    });
                    if (!response.ok) {
                        throw new Error('Erreur lors de l\'ajout de la notification');
                    }
                    const data = await response.json();
                    console.log(data);
                } catch (error) {
                    console.error(error);
                }
            } else {
                alert("Vous n'avez pas les autorisations nécessaires.");
            }
        },
        getUserRole() {
            return 'Manager';
        }
    },
}
</script>

<style>
.column {
    display: flex;
    height: 100%;
    padding: 50px;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
}

.top-column {
    display: flex;
    align-items: center;
    flex-direction: column;
}

.profile-button {
    width: 70px;
    height: 70px;
    border: solid 1px #8d8d8d;
    box-shadow: 0 4px 4px rgba(0, 0, 0, 0.2)
}

.notif-button {
    width: 55px;
    height: 55px;
    margin-top: 10px;
    border: solid 1px #8d8d8d;
    box-shadow: 0 4px 4px rgba(0, 0, 0, 0.2)
}

.center-button {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    position: relative;
    font-size: 30px
}

</style>