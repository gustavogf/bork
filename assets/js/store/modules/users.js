import UserService from '../../services/user-service';

const state = {
  currentUser: null
};

const getters = {};

const actions = {
  loadCurrentUser({ commit }) {
    UserService.getCurrentUser()
    .then((response) => {
      commit('setCurrentUser', response.data);
    })
    .catch((error) => {
      console.log(error);
    })
  }
};

const mutations = {
  setCurrentUser(state, user) {
    state.currentUser = user;
  }
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
