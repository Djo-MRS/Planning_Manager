import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import UserView from '@/views/UserView.vue';
import WorkingTimeView from '@/views/WorkingTimeView.vue';
import ProfileView from '@/views/ProfileView.vue';
import HelpView from '@/views/HelpView.vue';
import ManagerView from '@/views/ManagerView.vue';
import NotifView from '@/views/NotifView.vue';
import RequestView from '@/views/RequestView.vue';
import LoginView from '@/views/LoginView.vue';
import SignupView from '@/views/SignupView.vue';

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
  {
    path: '/manager',
    name: 'ManagerView',
    component: ManagerView
  },

  {
    path: '/notif',
    name: 'NotifView',
    component: NotifView
  },
  {
    path: '/request',
    name: 'RequestView',
    component: RequestView
  },

  { 
    path: '/sign_in', 
    component: LoginView
  },
  { 
    path: '/sign_up',
    component: SignupView
  },

];

const router = createRouter({
  history: createWebHistory(),
  routes
});

/* Middleware pour vérifier l'authentification
router.beforeEach((to, from, next) => {
  const isAuthenticated = !!localStorage.getItem('userId'); // Vérifie si l'utilisateur est connecté
  if (to.path !== '/sign_in' && to.path !== '/sign_up' && !isAuthenticated) {
    next('/sign_in'); // Redirige vers la page de connexion si non authentifié
  } else {
    next(); 
  }
});
*/
export default router;