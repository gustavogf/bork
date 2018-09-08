<template>
  <div class="top-navbar-content">
    <a href="#" class="top-navbar__menu-button" v-on:click="openNav()">
      <i class="material-icons">
        menu
      </i>
    </a>
    <h2 class="top-navbar__title">BorkQ</h2>
    <a href="#" class="top-navbar__logout">Sair</a>
  </div>
</template>
<script>
import ScreenUtils from '../utils/screenUtils.js';

export default {
  mounted() {
    this.addListenerToMenu();
  },
  methods: {
    addListenerToMenu() {
      if (ScreenUtils.isMobile()){
        const specifiedElement = document.querySelector('.side-navbar');
        const openMenuButtom = document.querySelector('.top-navbar__menu-button');

        document.addEventListener('click', function(event) {
          const isClickInsideMenu = specifiedElement.contains(event.target);
          const isClickInHeaderButton = openMenuButtom.contains(event.target);

          if (!isClickInsideMenu && !isClickInHeaderButton) {
            document.querySelector('.side-navbar').style.width = '0';
          }
        });
      }
    },
    openNav() {
      document.querySelector('.side-navbar').style.width = '250px';
    },
    closeNav() {
      document.querySelector('.side-navbar').style.width = '0';
    },
  }
};
</script>
