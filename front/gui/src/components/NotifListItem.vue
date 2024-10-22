<template>
    <div class="list-item-row">
        <div class="list-item-circle">
            <MDBBtn color="light" floating class="profile-button">
                <MDBIcon icon="user" style="font-size: 25px;"></MDBIcon> <!--Faire en fonction de l'user-->
            </MDBBtn>
        </div>
        <div class="list-item-column">
            <div class="title-request">Congés acceptés</div>
            <div class="title-message"> Vos congés du 30 octobre ont bien été acceptées</div>
            <div class="title-details">Il y a 2 mois</div>
        </div>
    </div>
</template>

<script>
import { MDBBtn, MDBIcon } from 'mdb-vue-ui-kit';


export default {
    name: 'RequestListItem',
    components: {
        MDBBtn,
        MDBIcon
    }
};
</script>

<style>
    .list-item-row{
        width: 100%;
        border-top: solid 1px #8d8d8d;
        display: flex;
        padding: 10px;
    }
    .list-item-circle{
        margin-right: 10px;
    }
    
    .title-request{
        font-size: 16px;
        font-weight: bold;
    }
    .title-message{
        font-size: 16px;
    }
    .title-details{
        font-size: 10px;
    }
</style>