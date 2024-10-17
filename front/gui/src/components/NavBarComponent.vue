<!--
<template>

<MDBNavbar light bg="light" expand="lg" class="mb-3" container>
    <MDBNavbarBrand href="/">TimeManager</MDBNavbarBrand>
    <MDBNavbarToggler
      target="#navbarNav"
      @click="collapse2 = !collapse2"
    ></MDBNavbarToggler>
    <MDBCollapse id="navbarNav" v-model="collapse2">
      <MDBNavbarNav>
        <MDBNavbarItem to="/" active> Home </MDBNavbarItem>
        <MDBNavbarItem to="/user"> User </MDBNavbarItem>
        <MDBNavbarItem to="/clock"> Clocking </MDBNavbarItem>
        <MDBNavbarItem to="/workingtime"> WorkingTime </MDBNavbarItem>
      </MDBNavbarNav>
    </MDBCollapse>
  </MDBNavbar>

  </template>

    <script>
    import { MDBNavbar, MDBNavbarBrand, MDBNavbarToggler, MDBCollapse, MDBNavbarNav, MDBNavbarItem } from "mdb-vue-ui-kit";

    export default {
    name: "NavBarComponent",
    components: {
        MDBNavbar,
        MDBNavbarBrand,
        MDBNavbarToggler,
        MDBCollapse,
        MDBNavbarNav,
        MDBNavbarItem
    },
    data() {
        return {
        collapse2: false
        };
    }
    };

    </script>

    <style>
    </style>
-->

<template>
  <div class="box-group">
    <MDBBtnGroup class="button-group rounded-pill" >
      <MDBBtn color="light" @click="goToPage('/workingtime')">
        <i class="fas fa-calendar-alt icon" ></i>
      </MDBBtn>
      <MDBBtn color="light" @click="goToPage('/manager')">
        <i class="fas fa-users-cog icon" ></i>
      </MDBBtn>
      <MDBBtn color="light" @click="goToPage('/request')">
        <i class="fas fa-envelope icon"></i>
      </MDBBtn>
    </MDBBtnGroup>
  </div>
</template>
  
<script>
  import { MDBBtnGroup, MDBBtn } from "mdb-vue-ui-kit";

  export default {
  name: "NavBarComponent",
  components: {
      MDBBtnGroup,
      MDBBtn,
  },
  methods: {
    goToPage(path) {
      this.$router.push(path);
    }
  },
  data() {
      return {
      collapse2: false
      };
  }
  };

</script>

<style>

  .box-group{
    display: flex;
    align-items: center;
    justify-content: center;
    position: fixed;
    bottom: 30px;
    width: 100%;
  }
  .button-group {
    border-radius: 30px !important; /* Modifier le border-radius du groupe de boutons */
    
  }
  .icon{
    font-size: 22px;
    padding-inline: 25px;
  }

  
</style>