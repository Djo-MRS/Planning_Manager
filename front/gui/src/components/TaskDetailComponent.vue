<template>
    <div>
      <h1>Edit Task</h1>
      <input v-model="task.name" placeholder="Task Name" />
      <button @click="handleUpdate">Update Task</button>
      <button @click="handleDelete">Delete Task</button>
    </div>
  </template>
  
  <script>
  export default {
    props: ['taskId'],
    data() {
      return {
        task: {},
      };
    },
    mounted() {
      fetch(`/api/tasks/${this.taskId}`)
        .then(response => response.json())
        .then(data => this.task = data);
    },
    methods: {
      handleUpdate() {
        fetch(`/api/tasks/${this.taskId}`, {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(this.task),
        });
      },
      handleDelete() {
        fetch(`/api/tasks/${this.taskId}`, { method: 'DELETE' });
      },
    },
  };
  </script>
  