<template>
  <ul class="collection with-header">
    <li class="collection-header"><h4>Qual sprint?</h4></li>
    <div v-for="sprint in sprints">
      <a href="#!" class="collection-item">{{ sprint.name }}</a>
    </div>
  </ul>
</template>
<script>
import SprintService from '../services/sprint-service';

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
    }
  }
};

</script>
