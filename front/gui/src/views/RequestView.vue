<template>
    <h2 class="title"> Mes demandes </h2>
    <div class="container-grid">
        <div class="main-content">      
            <div class="body-row">
                <RequestFormComponent/>
                <RequestListComponent class="request-list"/>
            </div>    
        </div>
        <section class="right-bar">
            <RightBarComponent/>
        </section>
    <NavBarComponent />
    </div>
</template>

<script>
import NavBarComponent from '@/components/NavBarComponent.vue';
import RequestFormComponent from '@/components/RequestFormComponent.vue';
import RequestListComponent from '@/components/RequestListComponent.vue';
import RightBarComponent from '@/components/RightBarComponent.vue';


export default {
    name: 'RequestView',
    components: {
        RequestFormComponent,
        RequestListComponent,
        RightBarComponent,
        NavBarComponent
    }
};
</script>

<style>

    .body-row{
        display: flex;
        justify-content: space-between;
        padding: 40px;
    }

    .title{
        margin: 15px;
    }

    @media (max-width: 768px) {
        .body-row{
            flex-direction: column;
            gap: 10px;
            padding-inline: 20px;
            padding-top: 0px;
        }
        .request-list {
            display: none; 
        }

        .main-content{
            padding: 0px;
        }
    }

</style>