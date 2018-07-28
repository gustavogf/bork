<template>
  <div v-if="closureFinished">
    <div class="row" >
      <div class="col s12">
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
      closureFinished: false,
      postits: {},
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
          this.closureFinished = true;
          this.loadPostits();
        }
      })
      .catch((error) => {
        debugger;
        alert('Erro ao checar se o fechamento ja fechou');
      });
    }
  }
};
</script>
