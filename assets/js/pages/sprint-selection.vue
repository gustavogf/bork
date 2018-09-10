<template>
  <div class="box">
    <div class="box-header">
      <h4>Selecione o Sprint</h4>
    </div>
    <div class="box-content__list">
      <ul>
        <li v-for="sprint in sprints" class="box-content__list-item">
          <a href="#" class="box-content__list-item__link" @click="createClosure(sprint.id)">
            <span class="box-content__list-item__label">
              {{ sprint.name }}
            </span>

            <i class="material-icons">
              chevron_right
            </i>
          </a>
        </li>
      </ul>
    </div>
  </div>
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
  }
};

</script>
