<template>
    <div class="task-cell" @click="handleClick">
        <ManagerModalComponent
            :showModal="isModifyModalOpen" 
            :currentDate="currentDate" 
            :task="task"
            :users="users" 
            :from="modify"
            :current_user="current_user"
            @close="closeModifyModal"   
            />
    </div>
</template>
  
<script>
import ManagerModalComponent from './ManagerModalComponent.vue';

    export default {
        name: "TaskItemComponent",
        components: {
            ManagerModalComponent,
        },
        data() {
            return {
                modify: "modify",
                isModifyModalOpen: false,
                currentTask: null,
                currentDate: new Date(),
                users: []
            };
        },
        props: {
            type: {
                type: String,
                required: true,
            },
            task: {
                type: Object,
                required: true
            },
            current_user: {
                type: Object,
            }
        },
        methods: {
            handleClick() {
                this.currentTask = this.task;  
                this.isModifyModalOpen = true;  
            },
            closeModifyModal() {
                this.isModifyModalOpen = false;
            }
        },
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
  