<template>
    <div>
      <h1>Tasks</h1>
      <ul>
        <li v-for="task in tasks" :key="task.id">
          <router-link :to="`/tasks/${task.id}`">{{ task.name }}</router-link>
        </li>
      </ul>
      <input v-model="newTask" placeholder="New Task" />
      <button @click="handleAddTask">Add Task</button>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        tasks: [],
        newTask: '',
      };
    },
    mounted() {
      this.fetchTasks();
    },
    methods: {
      fetchTasks() {
        fetch('/api/tasks')
          .then(response => response.json())
          .then(data => this.tasks = data);
      },
      handleAddTask() {
        fetch('/api/tasks', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ name: this.newTask }),
        }).then(() => {
          this.newTask = '';
          this.fetchTasks();
        });
      },
    },
  };
  </script>
  