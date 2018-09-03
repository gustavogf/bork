import "phoenix_html";
import 'es6-promise/auto';
import VueRouter from 'vue-router';
import store from './store';
import VueResource from 'vue-resource';
import router from './router.js';
import SideNavbar from './layouts/side-navbar.vue';
import TopNavbar from './layouts/top-navbar.vue';
import MainContent from './layouts/main-content.vue';

Vue.use(VueRouter);
Vue.use(VueResource);

window.vueApp = new Vue({
  el: "#app",
  router,
  store,
  components: {
    SideNavbar,
    TopNavbar,
    MainContent,
  }
});
