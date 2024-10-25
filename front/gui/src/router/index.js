import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import ProfileView from '@/views/ProfileView.vue';
import HelpView from '@/views/HelpView.vue';
import ManagerDashboardView from '@/views/ManagerDashboardView.vue';
import ManagerTeamsView from '@/views/ManagerTeamsView.vue';
import NotifView from '@/views/NotifView.vue';
import RequestView from '@/views/RequestView.vue';
import LoginView from '@/views/LoginView.vue';
import SignupView from '@/views/SignupView.vue';

const routes = [
  {
    path: '/', 
    name: 'LoginView',
    component: LoginView,
  },
  {
    path: '/home',
    name: 'HomeView',
    component: HomeView,
  },
  {
    path: '/profile',
    name: 'ProfileView',
    component: ProfileView,
  },
  {
    path: '/help',
    name: 'HelpView',
    component: HelpView,
  },
  {
    path: '/dashboard',
    name: 'ManagerDashboardView',
    component: ManagerDashboardView,
  },
  {
    path: '/teams',
    name: 'ManagerTeamsView',
    component: ManagerTeamsView,
  },
  {
    path: '/notif',
    name: 'NotifView',
    component: NotifView,
  },
  {
    path: '/request',
    name: 'RequestView',
    component: RequestView,
  },
  { 
    path: '/sign_in', 
    name: 'SigninView',
    component: LoginView,
  },
  { 
    path: '/sign_up',
    name: 'SignupView',
    component: SignupView,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
