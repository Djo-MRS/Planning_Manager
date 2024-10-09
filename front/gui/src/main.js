import 'mdb-vue-ui-kit/css/mdb.min.css'
import { createApp } from 'vue'
import HomeView from '@/views/HomeView.vue'
import router from './router/index.js'

createApp(HomeView).use(router).mount('#app')
