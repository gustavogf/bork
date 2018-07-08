import VueRouter from 'vue-router';
import Home from './pages/home.vue';
import SquadSelection from './pages/squad-selection.vue';
import SprintSelection from './pages/sprint-selection.vue';
import Closure from './pages/closure.vue';

const router = new VueRouter({
  mode: 'history',
  base: '/',
  routes: [
    { path: '/', name: 'home', component: Home },
    { path: '/novo-fechamento/squads', name: 'new_closure_squads', component: SquadSelection },
    { path: '/novo-fechamento/squad/:squadId/sprints', name: 'new_closure_sprint', component: SprintSelection },
    { path: '/fechamento/:id', name: 'closure', component: Closure }
  ],
});

export default router;
