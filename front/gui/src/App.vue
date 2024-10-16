
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
-->


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
    
<style>
    .container-grid {
        display: flex;
        justify-content: space-between;
        height: 100vh;
        position: relative;
    }
    .main-content{
        flex-grow: 1;
        padding-bottom: 60px;
        padding-right: 100px;
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