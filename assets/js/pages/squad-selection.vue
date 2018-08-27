<template>
  <div>
    <list-box title="Selecione o Squad" :list="buildList()" />
  <!-- <ul class="collection with-header">
    <li class="collection-header"><h4>Qual squad?</h4></li>
    <div v-for="squad in squads">
      <router-link :to="{ name: 'new_closure_sprint', params: { squadId: squad.id } }" class="collection-item">
        {{ squad.name }}
      </router-link>
    </div>
  </ul> -->
</div>
</template>
<script>
import ListBox from '../components/list-box';
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
  },
  components: {
    ListBox,
  }
};

</script>
