<template>
    <div class="box-list">
        <div>Vos messages</div>
        <div class="list-container">
            <RequestListItem/>
            <RequestListItem/>
            <RequestListItem/>
            <RequestListItem/>
            <RequestListItem/>
            <RequestListItem/>
            <RequestListItem/>
            <RequestListItem/>
            <div style="border-top: solid 1px #8d8d8d;"></div>
        </div>

    </div>
</template>

<script>
import RequestListItem from './RequestListItem.vue';


export default {
    name: 'RequestListComponent',
    components: {
        RequestListItem
    }
};
</script>

<style>
.box-list {
    width: 100%;
    margin-left: 30px;
}
.list-container {
  overflow-y: auto;
  max-height: 550px;
  padding-right: 15px; 
}


.list-container::-webkit-scrollbar {
  width: 8px;
}

.list-container::-webkit-scrollbar-thumb {
  background-color: #8d8d8d;
  border-radius: 4px;
}
</style>