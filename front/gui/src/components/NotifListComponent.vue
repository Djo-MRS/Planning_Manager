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
  @media (max-width: 768px) {
      .box-list{
        margin-left: 0px;
      }
  }
.box-list {
    width: 100%;
    margin-left: 30px;
}
.list-container {
  overflow-y: auto;
  max-height: 750px;
  padding-right: 15px; 
}

/* Optionnel : style pour personnaliser la barre de défilement */
.list-container::-webkit-scrollbar {
  width: 8px;
}


.list-container::-webkit-scrollbar-thumb {
  background-color: #8d8d8d;
  border-radius: 4px;
}

</style>