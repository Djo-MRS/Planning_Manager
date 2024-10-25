import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import ProfileView from '@/views/ProfileView.vue';
import HelpView from '@/views/HelpView.vue';
import ManagerView from '@/views/ManagerView.vue';
import NotifView from '@/views/NotifView.vue';
import RequestView from '@/views/RequestView.vue';
import LoginView from '@/views/LoginView.vue';
import SignupView from '@/views/SignupView.vue';
import TeamView from '@/views/TeamView.vue';

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
    path: '/manager',
    name: 'ManagerView',
    component: ManagerView,
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
  {
    path: '/team',
    name: 'TeamView',
    component: TeamView,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
