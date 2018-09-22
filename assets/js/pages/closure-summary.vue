<template>
  <div class="box" v-if="postits">
    <div class="tab">
      <button :class="['tab-item', positive ? 'tab-item--active' : '']" @click="setSelected(true)">
        Positivos
      </button>
      <button :class="['tab-item', !positive ? 'tab-item--active' : '']" @click="setSelected(false)">
        Negativos
      </button>
    </div>
    <div class="box-content">
      <div class="closure-summary__section" v-for="category in postits.positive.data" v-if="positive">
        <div class="closure-summary__category">
          <span>{{ category.category }}</span>
          <span>{{ category.total }}</span>
        </div>
        <div class="closure-summary__postit-description" v-for="positivePostit in category.postits" >
          {{ positivePostit.description }}
        </div>
      </div>
      <div class="closure-summary__section" v-for="category in postits.negative.data" v-if="!positive">
        <div class="closure-summary__category">
          <span>{{ category.category }}</span>
          <span>{{ category.total }}</span>
        </div>
        <div class="closure-summary__postit-description" v-for="negativePostit in category.postits" >
          {{ negativePostit.description }}
        </div>
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
      positive: true
    }
  },
  mounted() {
    this.checkIfClosureIsFinished();
  },
  methods: {
    setSelected(positive) {
      this.positive = positive;
    },
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
