<template>
  <div class="user">
      <MDBContainer>
      <div
        class="d-flex justify-content-center align-items-center"
        style="height: 100vh"
      >
      <h2>Create a user</h2>
        <div class="text-center">
          <form>
  <!-- Email input -->
  <div data-mdb-input-init class="form-outline mb-4">
    <input type="email" id="form1Example1" class="form-control" />
    <label class="form-label" for="form1Example1">Email address</label>
  </div>

  <!-- Password input -->
  <div data-mdb-input-init class="form-outline mb-4">
    <input type="password" id="form1Example2" class="form-control" />
    <label class="form-label" for="form1Example2">Password</label>
  </div>

  <!-- Submit button -->
  <button data-mdb-ripple-init type="submit" class="btn btn-primary btn-block">Sign in</button>
</form>
        </div>
      </div>
    </MDBContainer>
  </div>
</template>

<script>
import { MDBContainer } from "mdb-vue-ui-kit";

export default {
  name: "UserComponent",
  components: {
    MDBContainer
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
