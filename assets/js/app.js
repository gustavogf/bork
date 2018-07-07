import "phoenix_html";
import VueRouter from 'vue-router';
import router from './router.js';

Vue.use(VueRouter);

window.vueApp = new Vue({
  el: "#app",
  router
});
