<template>
    <div class="box-form">
        <div class="title-form">Faire une demande</div>
        <div class="form-container">
            <MDBDropdown v-model="dropdown1"  class="dropdown-container">
                <div class="label">Type de demande</div>
                <MDBDropdownToggle @click="dropdown1 = !dropdown1" color="light" class="dropdown-button">
                    Congés payées
                </MDBDropdownToggle>
                <MDBDropdownMenu aria-labelledby="dropdownMenuButton">
                    <MDBDropdownItem href="#">Congés payées</MDBDropdownItem>
                    <MDBDropdownItem href="#">RTT</MDBDropdownItem>
                    <MDBDropdownItem href="#">Arrêt maladie</MDBDropdownItem>
                </MDBDropdownMenu>
            </MDBDropdown>
            <MDBDropdown v-model="dropdown2" >
                <div class="label">Motif</div>
                <MDBDropdownToggle @click="dropdown2 = !dropdown2" color="light" class="dropdown-button">
                    Vancances
                </MDBDropdownToggle>
                <MDBDropdownMenu aria-labelledby="dropdownMenuButton">
                    <MDBDropdownItem href="#">Congés payées</MDBDropdownItem>
                    <MDBDropdownItem href="#">RTT</MDBDropdownItem>
                    <MDBDropdownItem href="#">Arrêt maladie</MDBDropdownItem>
                </MDBDropdownMenu>
            </MDBDropdown>
            <div class="date-picker-container">
                <label class="date-picker-label" for="date-input1" >Du :</label>
                <input class="date-picker-input" type="date" id="date-input1" v-model="selectedStartDate" />
            </div>
            <div class="date-picker-container">
                <label class="date-picker-label" for="date-input2">Au :</label>
                <input class="date-picker-input" type="date" id="date-input2" v-model="selectedEndDate" />
            </div>
            <div  class="comment-section">
                <div class="label">Commentaire</div>
                <MDBTextarea rows="4"  v-model="textareaValue" />
            </div>
            <div class="submit-section">
                <MDBBtn outline="primary">Envoyer</MDBBtn>
            </div>
        </div>
    </div>
</template>

<script>
import { MDBBtn, MDBDropdown, MDBDropdownItem, MDBDropdownMenu, MDBDropdownToggle, MDBTextarea } from 'mdb-vue-ui-kit';


export default {
    name: 'RequestFormComponent',
    components: {
        MDBDropdown, 
        MDBDropdownItem, 
        MDBDropdownMenu, 
        MDBDropdownToggle,
        MDBTextarea,
        MDBBtn,
    },
    data(){
        return {
            dropdown1: false,
            dropdown2: false,
            selectedStartDate : null,
            selectedEndDate : null,
            textareaValue: "",

        }
    }
};
</script>

<style>
    .box-form{
        width: 500px;

    }
    .form-container{
        border: solid 1px #8d8d8d;
        border-radius: 25px;
        padding: 20px;
    }
    .dropdown-button{
       width: 100%;
       border: solid #8d8d8d 1px;
       box-shadow: #8d8d8d;

    }
    .label{
        font-size: 14px;
        padding-left: 5px;
    }
    .dropdown-container{
        margin-bottom : 20px
    }
    .date-picker-container {
        margin-top: 20px;
    }
    .date-picker-label{
        margin-right: 20px;
        margin-left: 5px;
        font-size: 14px;
    }
    .date-picker-input{
        width: 100%;
        padding: 10px;
        border: 1px solid #8d8d8d;
        border-radius: 8px;
        font-size: 16px;
        color: #333;
        background-color: #f9f9f9;
        outline: none;
        transition: border-color 0.3s ease;
    }
    .comment-section{
        margin-top: 25px;
    }
    .submit-section{
        display: flex;
        margin-top: 20px;
        justify-content: flex-end;
    }
    .title-form{
        margin-left: 10px;
    }
</style>