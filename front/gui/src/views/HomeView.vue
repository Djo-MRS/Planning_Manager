<template>
    <div class="container-grid">
        <div class="main-content">       
            <HomeComponent />
        </div>
        <section class="right-bar">
            <RightBarComponent/>
        </section>
        <NavBarComponent />
    </div>
</template>

<script>
    import NavBarComponent from '@/components/NavBarComponent.vue';
    import RightBarComponent from '@/components/RightBarComponent.vue';
    import HomeComponent from '@/components/HomeComponent.vue';

    export default {
        name: 'App',
        components: {
            HomeComponent,
            NavBarComponent,
            RightBarComponent,
        }
    };
</script>


<style>
    .main-content{
        padding: 50px;
    }
</style>