import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import UserView from '@/views/UserView.vue';

const routes = [
    {
        path: '/',
        name: 'HomeView',
        component: HomeView
    },
  {
    path: '/user',
    name: 'UserView',
    component: UserView
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;