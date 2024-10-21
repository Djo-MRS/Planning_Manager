<template>
    <div class="column">
        <div class="top-column">
            <MDBBtn color="light" floating class="profile-button" @click="goToPage('/profile')">
                <MDBIcon icon="user" style="font-size: 25px;"></MDBIcon>
            </MDBBtn>
            <MDBBtn color="light" floating class="notif-button" @click="goToPage('/notif')">
                <MDBIcon icon="bell" style="font-size: 18px;"></MDBIcon>
            </MDBBtn>
        </div>
        <MDBBtn color="light" floating class="notif-button" @click="goToPage('/help')">
            <MDBIcon icon="question" style="font-size: 18px;"></MDBIcon>
        </MDBBtn>
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
    methods: {
    goToPage(path) {
      this.$router.push(path); 
    }
  },
    data() {
        return {
    
        };
    }
    };
  
  </script>
  
  <style>
  
    .column{
        display: flex;
        height: 100%;
        padding: 50px;
        flex-direction: column;
        justify-content: space-between;
        align-items: center;
    }
    
    .top-column{
        display: flex;
        align-items: center;
        flex-direction: column;
    }
    
    .profile-button{
        width: 70px;
        height: 70px;
        border: solid 1px #8d8d8d;
        box-shadow: 0 4px 4px rgba(0, 0, 0, 0.2)    
    }
    .notif-button{
        width: 55px;
        height: 55px;
        margin-top: 10px;
        border: solid 1px #8d8d8d;
        box-shadow: 0 4px 4px rgba(0, 0, 0, 0.2)    
    }
    
  </style>