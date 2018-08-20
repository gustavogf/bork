import "phoenix_html";
import 'es6-promise/auto';
import VueRouter from 'vue-router';
import store from './store';
import VueResource from 'vue-resource';
import router from './router.js';
import MenuLayout from './components/menu-layout.vue';
import HeaderLayout from './components/header-layout.vue';
import MainLayout from './components/main-layout.vue';

Vue.use(VueRouter);
Vue.use(VueResource);

window.vueApp = new Vue({
  el: "#app",
  router,
  store,
  components: {
    MenuLayout,
    HeaderLayout,
    MainLayout,
  }
});
