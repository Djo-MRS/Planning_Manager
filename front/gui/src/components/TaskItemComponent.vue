<template>
    <div class="task-cell">

    </div>
</template>
  
<script>
    
    export default {
        name: "NavBarComponent",
        components: {
        },
        methods: {

        },
        data() {
            return {
            
            };
        },
        props: {
            currentTask:{
                type: Object,
                required: true, 
            }
        }
    };

   
</script>

<style>
     .task-cell{
        background-color: #11c7e7;
        width: 100%;
        height: 60%;
        border-radius: 4px;
    }
</style>
  