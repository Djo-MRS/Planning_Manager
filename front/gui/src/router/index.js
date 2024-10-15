import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import UserView from '@/views/UserView.vue';
import ClockingView from '@/views/ClockingView.vue';
import WorkingTimeView from '@/views/WorkingTimeView.vue';
import ClockingComponent2 from '@/components/ClockingComponent2.vue';

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
    path: '/clock',
    name: 'ClockingView',
    component: ClockingView
  }, 
  {
    path: '/workingtime',
    name: 'WorkingTimeView',
    component: WorkingTimeView
  },
  {
    path: '/test',
    name: 'test',
    component: ClockingComponent2
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;