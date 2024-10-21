<template>
    <div class="container-grid">
        <div class="main-content">      
            <HelpComponent />
        </div>
        <section class="right-bar">
            <RightBarComponent/>
        </section>
        <NavBarComponent />
    </div>
</template>

<script>
import HelpComponent from '@/components/HelpComponent.vue';
import RightBarComponent from '@/components/RightBarComponent.vue';
import NavBarComponent from '@/components/NavBarComponent.vue';

export default {
    name: 'HelpView',
    components: {
        HelpComponent,
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