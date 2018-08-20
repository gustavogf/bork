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
          <router-link :to="{ name: 'new_closure_squads' }" class="menu-layout__list-item btn btn1">
            Retrospectiva
          </router-link>
        </li>
      </ul>
    </div>
  </div>
</template>
<style lang="scss">
@import 'css/colors';

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

.menu__list-wrapper {
}

.menu__list {
}
</style>
