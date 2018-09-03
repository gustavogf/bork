<template>
  <div class="header">
    <a href="#" class="header__menu-buttom" v-on:click="openNav()">
      <i class="material-icons">
        menu
      </i>
    </a>
    <h2 class="header__title">BorkQ</h2>
    <a href="#" class="header__logout">Sair</a>
  </div>
</template>
<style lang="scss">
@import 'css/style/variables';
.header {
  display: grid;
  grid-columns: 3;
  grid-template-areas: 'menu-buttom title logout';
}

.header__title {
  grid-area: title;
  text-align: center;

  @media only screen and (min-width: $screen-md-min) {
    grid-column: 1/2;
    text-align: left;
  }
}

.header__logout {
  grid-area: logout;
  text-align: right;
  align-items: center;
}

.header__menu-buttom {
  grid-area: menu-buttom;

  @media only screen and (min-width: $screen-md-min) {
    display: none;
  }
}
</style>
<script>
export default {
  mounted() {
    this.addListenerToMenu();
  },
  methods: {
    addListenerToMenu() {
      if (this.isMobile()){
        const specifiedElement = document.querySelector('.menu-wrapper');
        const openMenuButtom = document.querySelector('.header__menu-buttom');

        document.addEventListener('click', function(event) {
          const isClickInsideMenu = specifiedElement.contains(event.target);
          const isClickInHeaderButton = openMenuButtom.contains(event.target);

          if (!isClickInsideMenu && !isClickInHeaderButton) {
            document.querySelector('.menu-wrapper').style.width = '0';
          }
        });
      }
    },
    openNav() {
      document.querySelector('.menu-wrapper').style.width = '250px';
    },
    closeNav() {
      document.querySelector('.menu-wrapper').style.width = '0';
    },
    isMobile() {
      if(window.innerWidth < 992) {
        return true;
      } else {
        return false;
      }
    }
  }
};
</script>
