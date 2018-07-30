<template>
  <div>
    <nav style="background-color: #18acc4">
      <div class="nav-wrapper">
        <div class="row">
          <div class="col s12">
            <a href="#" data-target="slide-out" class="sidenav-trigger show-on-large"><i class="material-icons">menu</i></a>
            <a href="/" class="brand-logo">BorkQ</a>
            <ul id="nav-mobile" class="right hide-on-med-and-down">
            </ul>
          </div>
        </div>
      </div>
    </nav>
    <ul id="slide-out" class="sidenav">
      <li style="color: #fff; background-color: #18acc4">
        <div class="user-view" v-if="currentUser">
          <a href="#" style="color: #fff"><span class="name">{{ currentUser.name }}</span></a>
          <a href="#" style="color: #fff"><span class="email">Squad</span></a>
          <a href="#" style="color: #fff"><span class="email">Sprint</span></a>
        </div>
      </li>
      <li><a class="waves-effect" href="/novo-fechamento/squads">Fechamento</a></li>
    </ul>
  </div>
</template>

<script>
document.addEventListener('DOMContentLoaded', function() {
  var elems = document.querySelectorAll('.sidenav');
  var instances = M.Sidenav.init(elems);
});

import { mapState, mapActions } from 'vuex';

export default {
  computed: mapState({
    currentUser: state => state.users.currentUser,
  }),
  mounted () {
    this.$store.dispatch('users/loadCurrentUser');
  }
};
</script>
