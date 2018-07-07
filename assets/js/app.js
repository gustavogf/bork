import "phoenix_html";
import VueRouter from 'vue-router';
import VueResource from 'vue-resource';
import router from './router.js';

Vue.use(VueRouter);
Vue.use(VueResource);

window.vueApp = new Vue({
  el: "#app",
  router
});
