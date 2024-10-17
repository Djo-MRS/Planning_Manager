import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import UserView from '@/views/UserView.vue';
import WorkingTimeView from '@/views/WorkingTimeView.vue';
import ProfileView from '@/views/ProfileView.vue';
import HelpView from '@/views/HelpView.vue';

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
    path: '/profile',
    name: 'ProfileView',
    component: ProfileView
  },
  {
    path: '/help',
    name: 'HelpView',
    component: HelpView
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