<template>
  <div class="box">
    <div class="box-header">
      <h4>Selecione o Sprint</h4>
    </div>
    <div class="box-content__list">
      <ul>
        <li v-for="item in buildList()" class="box-content__list-item">
          <router-link :to="buildPath(item)" class="box-content__list-item__link" >
            <span class="box-content__list-item__label">
              {{ item.label }}
            </span>

            <i class="material-icons">
              chevron_right
            </i>
          </router-link>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
import SquadService from '../services/squad-service';

export default {
  data() {
    return {
      squads: []
    }
  },
  mounted() {
    this.loadSquads();
  },
  methods: {
    loadSquads(){
      SquadService.getSquads()
      .then((response) => {
        this.squads = response.data;
      })
      .catch((error) => {
        alert('Erro ao carregar squads');
      })
    },
    buildList(){
      var list = [];
      this.squads.forEach((squad) => {
        list.push({
          label: squad.name,
          pathName: 'new_closure_sprint',
          pathParams: { squadId: squad.id },
        });
      });
      return list;
    },
    buildPath(item) {
      return { name: item.pathName, params: item.pathParams };
    }
  },
};

</script>
