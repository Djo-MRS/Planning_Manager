<template>
  <div class="box-group">
    <MDBBtnGroup class="button-group rounded-pill">
      <MDBBtn color="light" @click="goToPage('/home')">
        <i class="fas fa-home-alt icon"></i>
      </MDBBtn>
      <MDBBtn  color="light" @click="goToPage('/dashboard')" v-if="isManagerOrAdmin">
        <i class="fas fa-users-cog icon"></i>
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
  computed: {
    isManagerOrAdmin() {
      const role = JSON.parse(localStorage.getItem('user')).role;
      return role === 'manager' || role === 'admin';
    },
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
.box-group {
  display: flex;
  align-items: center;
  justify-content: center;
  position:fixed;
  bottom: 20px;
  width: 100%;
  left: 0;
  right: 0;
  z-index: 1000;
}
.button-group {
  border-radius: 20px !important; /* Modifier le border-radius du groupe de boutons */
}
.icon {
  font-size: 22px;
  padding-inline: 25px;
}
@media (max-width: 768px) {
  .box-group {
    bottom: 10px;
    width: auto;
  }
}
</style>
