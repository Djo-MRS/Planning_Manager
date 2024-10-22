import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import ProfileView from '@/views/ProfileView.vue';
import HelpView from '@/views/HelpView.vue';
import ManagerView from '@/views/ManagerView.vue';
import NotifView from '@/views/NotifView.vue';
import RequestView from '@/views/RequestView.vue';
import LoginView from '@/views/LoginView.vue';
import SignupView from '@/views/SignupView.vue';

const routes = [
  {
    path: '/home',
    name: 'HomeView',
    component: HomeView,
    meta: { requiresAuth: true },
  },
  {
    path: '/profile',
    name: 'ProfileView',
    component: ProfileView,
    // meta: { requiresAuth: true },
  },
  {
    path: '/help',
    name: 'HelpView',
    component: HelpView,
    // meta: { requiresAuth: true },
  },
  {
    path: '/manager',
    name: 'ManagerView',
    component: ManagerView,
    // meta: { requiresAuth: true },
  },
  {
    path: '/notif',
    name: 'NotifView',
    component: NotifView,
    // meta: { requiresAuth: true },
  },
  {
    path: '/request',
    name: 'RequestView',
    component: RequestView,
    // meta: { requiresAuth: true },
  },
  { 
    path: '/sign_in', 
    name: 'LoginView',
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

// Middleware pour vérifier l'authentification
router.beforeEach((to, from, next) => {
  const isAuthenticated = !!localStorage.getItem('userId'); // Vérifie si l'utilisateur est connecté
  if (to.matched.some(record => record.meta.requiresAuth) && !isAuthenticated) {
    next('/sign_in'); // Redirige vers la page de connexion si non authentifié
  } else {
    next(); 
  }
});

export default router;
