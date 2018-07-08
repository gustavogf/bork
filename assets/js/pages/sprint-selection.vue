<template>
  <ul class="collection with-header">
    <li class="collection-header"><h4>Qual sprint?</h4></li>
    <div v-for="sprint in sprints">
      <a href="#" class="collection-item" @click="createClosure(sprint.id)">{{ sprint.name }}</a>
    </div>
  </ul>
</template>
<script>
import SprintService from '../services/sprint-service';
import ClosureService from '../services/closure-service';

export default {
  data() {
    return {
      sprints: []
    }
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
        alert(error);
      })
    },
    createClosure(sprintId) {
      const squadId = this.$route.params.squadId;
      ClosureService.createClosure(parseInt(squadId), parseInt(sprintId))
      .then((response) => {
        this.$router.push({ name: 'closure', params: { id: response.data } });
      })
      .catch((error) => {
        alert(error);
      })
    }
  }
};

</script>
