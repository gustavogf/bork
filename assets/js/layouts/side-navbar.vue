<template>
  <div>
    <div class="menu__profile">
      <h3 class="menu__profile-name">Sergio</h3>
      <h5 class="menu__profile-squad">Quero Pago</h5>
      <h5 class="menu__profile-sprint">s03-2018.2</h5>
    </div>
    <div class="menu__list-wrapper">
      <ul class="menu__list">
        <li class="menu__list-item">
          <router-link :to="{ name: 'new_closure_squads' }" class="menu-button" @click="closeMenu">
            Retrospectiva
          </router-link>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
export default {
  methods: {
    closeMenu() {
      debugger;
      document.querySelector('.menu-wrapper').style.width = '0';
    }
  }
}
</script>
<style lang="scss">
@import 'css/style/colors';

.menu__profile {
  background-color: $light-blue;
  color: $white;
  padding: 12px;
}

.menu__profile-name {
  margin-top: 16px;
}

.menu__profile-squad {
  margin-bottom: 8px;
}

.menu__profile-sprint {
  margin-bottom: 16px;
}

.menu-button {
  background: transparent;
  background-color: $white;
  border-bottom: 1px solid $gray;
  color: $white;
  box-sizing: border-box;
  padding: 16px 12px;
  display: inline-block;
  -webkit-transition-duration: 0.4s; /* Safari */
  transition-duration: 0.4s;
  cursor: pointer;
  text-decoration: none;
  color: $dark-gray;
  width: 100%;

  &:hover {
    background-color: $orange;
    color: $white;
  }
}
</style>
