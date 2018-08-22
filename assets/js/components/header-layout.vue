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
@import 'css/variables';

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
var specifiedElement = document.querySelector('.menu-wrapper');

//I'm using "click" but it works with any event
document.addEventListener('click', function(event) {
  var isClickInside = specifiedElement.contains(event.target);

  if (!isClickInside) {
    document.querySelector('.menu-wrapper').style.width = '0';
  }
});

export default {
  methods: {
    openNav() {
      document.querySelector('.menu-wrapper').style.width = '250px';
    },
    closeNav() {
      document.querySelector('.menu-wrapper').style.width = '0';
    }
  }
};
</script>
