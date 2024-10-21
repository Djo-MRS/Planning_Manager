<template>
    <div>
      <h1>Skills Manager</h1>
      <ul>
        <li v-for="skill in skills" :key="skill.id">
          <router-link :to="`/skills/${skill.id}`">{{ skill.name }}</router-link>
        </li>
      </ul>
      <input v-model="newSkill" placeholder="New Skill" />
      <button @click="handleAddSkill">Add Skill</button>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        skills: [],
        newSkill: '',
      };
    },
    mounted() {
      this.fetchSkills();
    },
    methods: {
      fetchSkills() {
        fetch('/api/skills')
          .then(response => response.json())
          .then(data => this.skills = data);
      },
      handleAddSkill() {
        fetch('/api/skills', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ name: this.newSkill }),
        }).then(() => {
          this.newSkill = '';
          this.fetchSkills();
        });
      },
    },
  };
  </script>
  