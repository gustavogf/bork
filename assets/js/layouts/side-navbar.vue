<template>
  <div>
    <div class="side-navbar__profile">
      <h3 class="side-navbar__profile-name">Sergio</h3>
      <h5 class="side-navbar__profile-squad">Quero Pago</h5>
      <h5 class="side-navbar__profile-sprint">s03-2018.2</h5>
    </div>
    <div class="side-navbar__list-wrapper">
      <ul class="side-navbar__list">
        <li class="side-navbar__list-item">
          <router-link :to="{ name: 'new_closure_squads' }" class="side-navbar-button" v-on:click.native="closeMenu">
            Retrospectiva
          </router-link>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
import ScreenUtils from '../utils/screenUtils.js';

export default {
  methods: {
    closeMenu() {
      if(ScreenUtils.isMobile()) {
        document.querySelector('.side-navbar').style.width = '0';
      }
    }
  }
}
</script>
