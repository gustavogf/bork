<template>
  <div v-if="postits !== null">
    <div class="row" align="center">
      <div class="col s12">
        <h4>Positivos</h4>
      </div>
    </div>
    <div v-for="positive in postits.positive.data">
      <div class="row">
        <div class="col s12" align="center">
          <ul class="collection with-header">
            <li class="collection-header">
              <h5>{{positive.category}}</h5>
            </li>
            <li class="collection-item" v-for="postit in positive.postits">
              {{ postit.description }}
            </li>
          </ul>
        </div>
      </div>
    </div>
    <div class="row" align="center">
      <div class="col s12">
        <h4>Negativos</h4>
      </div>
    </div>
    <div v-for="negative in postits.negative.data">
      <div class="row">
        <div class="col s12" align="center">
          <ul class="collection with-header">
            <li class="collection-header"><h5>{{negative.category}}</h5></li>
            <li class="collection-item" v-for="postit in negative.postits">
              {{ postit.description }}
            </li>
          </ul>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col s12" align="center">
        Positivos: {{ postits.positive.total }}
        Negativos: {{ postits.negative.total }}
      </div>
    </div>
  </div>
</template>

<script>
import ClosureService from '../services/closure-service';
import PostitService from '../services/postit-service';

export default {
  data() {
    return {
      closureId: this.$route.params.id,
      postits: null,
    }
  },
  mounted() {
    this.checkIfClosureIsFinished();
  },
  methods: {
    loadPostits() {
      PostitService.getPostitsForSummary(this.closureId)
      .then((response) => {
        this.postits = response.data;
      })
      .catch((error) => {
        alert('Erro ao carregar os postits');
      })
    },
    checkIfClosureIsFinished() {
      ClosureService.checkIfClosureIsFinished(this.closureId)
      .then((response) => {
        if(!response.data.finished) {
          this.$router.push({ name: 'closure', params: { id: this.closureId } })
        } else {
          this.loadPostits();
        }
      })
      .catch((error) => {
        alert('Erro ao checar se o fechamento ja fechou');
      });
    }
  }
};
</script>
