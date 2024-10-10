import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import UserView from '@/views/UserView.vue';
import ClockingView from '@/views/ClockingView.vue';
import WorkingTimeView from '@/views/WorkingTimeView.vue';

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
    path: '/clock/:userId',
    name: 'ClockingView',
    component: ClockingView
  }, 
  {
    path: '/workingtime',
    name: 'WorkingTimeView',
    component: WorkingTimeView
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;