<template>

<MDBNavbar light bg="light" expand="lg" container>
    <MDBNavbarBrand href="/">TimeManager</MDBNavbarBrand>
    <MDBNavbarToggler
      target="#navbarNav"
      @click="collapse2 = !collapse2"
    ></MDBNavbarToggler>
    <MDBCollapse id="navbarNav" v-model="collapse2">
      <MDBNavbarNav>
        <MDBNavbarItem to="/" active> Home </MDBNavbarItem>
        <MDBNavbarItem to="/user"> User </MDBNavbarItem>
        <MDBNavbarItem to="#"> WorkingTime </MDBNavbarItem>
        <MDBNavbarItem to="/clock/1"> Clocking </MDBNavbarItem>
        <MDBNavbarItem to="/workingtime"> WorkingTime </MDBNavbarItem>
        <MDBNavbarItem to="#"> Clocking </MDBNavbarItem>
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