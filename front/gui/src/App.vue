
<!--
    <template>
        <NavBarComponent />
        <HomeView />
    </template>
    
    <script>
    import NavBarComponent from './components/NavBarComponent.vue';
    import HomeView from './views/HomeView.vue';
    
    export default {
        name: 'App',
        components: {
            HomeView,
            NavBarComponent
        }
    };
    </script>
        
    <style>
    </style>



<template>
    <div class="container-grid">
        <div class="main-content">       
            <HomeView />
        </div>
        <section class="right-bar">
            <RightBarComponent/>
        </section>
        <NavBarComponent />
    </div>
</template>

<script>
    import NavBarComponent from './components/NavBarComponent.vue';
    import RightBarComponent from './components/RightBarComponent.vue';
    import HomeView from './views/HomeView.vue';

    export default {
        name: 'App',
        components: {
            HomeView,
            NavBarComponent,
            RightBarComponent,
        }
    };
</script>

-->

<!-- Ajout test bouton déconnexion Djo-->
<template>
    <NavBarComponent />
    <HomeView />
    <div id="app">
      <router-view></router-view>
      <button v-if="isAuthenticated" @click="logout">Déconnexion</button>
    </div>
  </template>
  
  <script>

import NavBarComponent from './components/NavBarComponent.vue';
// import RightBarComponent from './components/RightBarComponent.vue';
import HomeView from './views/HomeView.vue';

  export default {
      name: 'App',
        components: {
            HomeView,
            NavBarComponent,
           // RightBarComponent,
        },
        computed: {
      isAuthenticated() {
        return !!localStorage.getItem('userId');
      },
    },
    methods: {
      logout() {
        // Appel à l'API pour déconnecter l'utilisateur
        localStorage.removeItem('xsrfToken');
        localStorage.removeItem('userId');
        localStorage.removeItem('roleId');
        this.$router.push('/sign_in');
      },
    },
  };
  </script>
  
<style>
    .container-grid {
        display: flex;
        justify-content: space-between;
        height: 100vh;
        position: relative;
    }
    .main-content{
        flex-grow: 1;
    }
    .right-bar{
        position: fixed;
        right: 0;
        top: 0;
        height: 100%;
        width: 100px;
    }
    body {
        margin: 0;
        padding: 0;
        overflow: hidden;
    }
    nav {
        position: fixed;
        bottom: 0;
        width: 100%;
        z-index: 10; 
    }
</style>