<template>
    <div class="column">
        <div class="top-column">
            <MDBBtn color="light" floating class="profile-button" @click="goToPage('/profile')" id="rightbar-profile">
                <MDBIcon icon="user" style="font-size: 25px;"></MDBIcon>
            </MDBBtn>
            <MDBBtn color="light" floating class="notif-button" @click="goToPage('/notif')" id="rightbar-notif">
                <MDBIcon icon="bell" style="font-size: 18px;"></MDBIcon>
            </MDBBtn>
            <MDBBtn color="light" floating class="notif-button" @click="goToSignup" v-if="isAdmin" id="rightbar-signup">
                <MDBIcon icon="user-cog" style="font-size: 18px;"></MDBIcon>
            </MDBBtn> 
        </div>
        <div class="center-button">
            <MDBBtn color="light" floating class="notif-button" @click="triggerAlert" id="rightbar-alert">
                <i class="fab fa-earlybirds" style="font-size: 40px;"></i>
            </MDBBtn>
        </div>
        <MDBBtn color="light" floating class="notif-button" @click="$emit('tutoClicked')" id="rightbar-tuto">
            <MDBIcon icon="question" style="font-size: 18px;"></MDBIcon>
        </MDBBtn>
        <MDBBtn color="light" floating class="notif-button" @click="goToLogout" id="rightbar-logout">
            <MDBIcon icon="sign-out-alt" style="font-size: 18px;"></MDBIcon>
        </MDBBtn>
        
    </div>
</template>

<script>
import { MDBBtn, MDBIcon } from "mdb-vue-ui-kit";

export default {
    name: "RightBarComponent",
    components: {
        MDBBtn,
        MDBIcon,

    },
    methods: {
        async triggerAlert() {
         alert('BATMAN EST EN MISSION !!!');
        },
        goToSignup() {
            this.$router.push('/sign_up');
        },
        goToPage(path) {
            this.$router.push(path);
        },
        goToLogout() {
            localStorage.clear();
            this.$router.push('/sign_in');
        },
        getUserRole() {
            return JSON.parse(localStorage.getItem('user')).role;
        }
    },
}
</script>

<style>
.column {
    display: flex;
    position: fixed;
    height: 100%; 
    width: 80px; 
    padding: 10px; 
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
    z-index: 3000;
    right: 0;
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
}
@media (max-width: 768px) {
  .column {
    top: 10px; 
    right: 0; 
    padding: 10px;
    z-index: 3000;
    height: auto;
  }

}
</style>