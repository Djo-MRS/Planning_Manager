import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import UserView from '@/views/UserView.vue';
import WorkingTimeView from '@/views/WorkingTimeView.vue';
import HelpView from '@/views/HelpView.vue';
import ProfileView from '@/views/ProfileView.vue';

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
  },
  {
    path: '/workingtime',
    name: 'WorkingTimeView',
    component: WorkingTimeView
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;