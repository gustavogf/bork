<template>
  <list-box title="Selecione o Sprint" :list="buildList()" />
</template>
<script>
import SprintService from '../services/sprint-service';
import ClosureService from '../services/closure-service';
import ListBox from '../components/list-box';

export default {
  data() {
    return {
      sprints: []
    }
  },
  components: {
    ListBox,
  },
  mounted() {
    this.loadSprints();
  },
  methods: {
    loadSprints(){
      SprintService.getSprints()
      .then((response) => {
        this.sprints = response.data;
      })
      .catch((error) => {
        alert('Erro ao carregar sprints');
      })
    },
    createClosure(sprintId) {
      const squadId = this.$route.params.squadId;
      ClosureService.createClosure(parseInt(squadId), parseInt(sprintId))
      .then((response) => {
        this.$router.push({ name: 'closure', params: { id: response.data } });
      })
      .catch((error) => {
        alert('Erro ao criar fechamento');
      })
    },
    buildList(){
      var list = [];
      this.sprints.forEach((sprint) => {
        list.push({
          label: sprint.name,
          pathName: 'new_closure_sprint',
          pathParams: { squadId: sprint.id },
        });
      });
      return list;
    },
  }
};

</script>
