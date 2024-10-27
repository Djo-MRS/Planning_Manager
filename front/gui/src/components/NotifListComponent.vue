<template>
    <div class="box-list">
      <div>Vos notifications</div>
        <div class="list-container">
          <NotifListItem/>
          <NotifListItem/>
          <NotifListItem/>
          <NotifListItem/>
          <NotifListItem/>
          <NotifListItem/>
          <NotifListItem/>
          <NotifListItem/>
        <div style="border-top: solid 1px #8d8d8d;"></div>
      </div>
    </div>
</template>

<script>
import NotifListItem from './NotifListItem.vue';

export default {
    name: 'NotifListComponent',
    components: {
        NotifListItem
    }
};
</script>

<style>
.box-list {
    width: 100%;
    margin-left: 30px;
    max-height: 200px;
}
.list-container {
  overflow-y: auto;
  max-height: 500px;
  padding-right: 15px; 
}

.list-container::-webkit-scrollbar {
  width: 8px;
}

.list-container::-webkit-scrollbar-thumb {
  background-color: #8d8d8d;
  border-radius: 4px;
}

  @media (max-width: 768px) {
      .box-list{
        margin-left: 0px;
      }
  }


</style>