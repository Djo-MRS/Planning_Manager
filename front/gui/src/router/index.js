import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import ProfileView from '@/views/ProfileView.vue';
import ManagerDashboardView from '@/views/ManagerDashboardView.vue';
import ManagerTeamsView from '@/views/ManagerTeamsView.vue';
import NotifView from '@/views/NotifView.vue';
import RequestView from '@/views/RequestView.vue';
import LoginView from '@/views/LoginView.vue';
import SignupView from '@/views/SignupView.vue';
import ChartManager from '@/views/ChartManagerView.vue';

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
  {
    path: '/chartManager/:userID',
    name: 'ChartManager',
    component: ChartManager
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

router.beforeEach((to, from, next) => {
  const publicPages = ['/sign_in', '/sign_up'];
  const authRequired = !publicPages.includes(to.path);
  const loggedIn = localStorage.getItem('user');

  if (authRequired && !loggedIn) {
    return next('/sign_in');
  }

  next();
});

export default router;
