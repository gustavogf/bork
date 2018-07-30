import Vuex from 'vuex';
import users from './modules/users';
import squads from './modules/squads';
import sprints from './modules/sprints';

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    users,
    squads,
    sprints,
  },
})
