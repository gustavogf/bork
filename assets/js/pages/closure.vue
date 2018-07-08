<template>
  <div align="center">
    <div class="row">
      <div class="col s1">
        <div v-for="(positivePostit, index) in positivePostits">
          <a href="#" @click="setCurrentPosititvePostit(positivePostit)">{{ index }}</a>
        </div>
      </div>
      <div class="col s5" style="border-right: 1px solid #eaeaea;">
        <div class= "row">
          <div class="col s12">
            <h5>Positivos</h5>
          </div>
        </div>
        <div class="row">
          <div class="col s12">
            <select class="browser-default" v-model="currentPositivePostit.category_id">
              <option disabled value="">Selecione a categoria</option>
              <option v-for="category in categories" v-bind:value="category.id">
                {{ category.name }}
              </option>
            </select>
          </div>
        </div>
        <div class="row">
          <div class= "input-field col s12">
            <textarea class="materialize-textarea" v-model="currentPositivePostit.description" placeholder="Descrição do Postit"></textarea>
          </div>
        </div>
        <div class="row">
          <div class="col s12">
            <div v-if="currentPositivePostit.id">
              <div class="col s6">
                <button class="btn waves-effect waves-light red lighten-2">
                  Remover
                  <i class="material-icons right">delete</i>
                </button>
              </div>
              <div class="col s6">
                <button class="btn waves-effect waves-light">
                  Editar
                  <i class="material-icons right">edit</i>
                </button>
              </div>
            </div>
            <div v-else>
              <button class="btn waves-effect waves-light" @click="createPostit(currentPositivePostit)">
                Adicionar
                <i class="material-icons right">send</i>
              </button>
            </div>
          </div>
        </div>
      </div>
      <div class="col s5">
        <div class= "row">
          <div class="col s12">
            <h5>Negativos</h5>
          </div>
        </div>
        <div class="row">
          <div class="col s12">
            <select class="browser-default" v-model="currentNegativePostit.category_id">
              <option disabled value="">Selecione a categoria</option>
              <option v-for="category in categories" v-bind:value="category.id">
                {{ category.name }}
              </option>
            </select>
          </div>
        </div>
        <div class="row">
          <div class= "input-field col s12">
            <textarea class="materialize-textarea" v-model="currentNegativePostit.description" placeholder="Descrição do Postit"></textarea>
          </div>
        </div>
      </div>
      <div class="col s1">
        <div v-for="(negativePostit, index) in negativePostits">
          <a href="#" @click="setCurrentPosititvePostit(negativePostit)">{{ index }}</a>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col s12">

      </div>
    </div>
  </div>
</template>
<script>
import CategoryService from '../services/category-service';
import PostitService from '../services/postit-service';

export default {
  data() {
    return {
      currentPositivePostit: {
        category_id: '', description: '', closure_id: parseInt(this.$route.params.id), positive: true
      },
      currentNegativePostit: {
        category_id: '', description: '', closure_id: parseInt(this.$route.params.id), positive: false
      },
      positivePostits: [],
      negativePostits: [],
      categories: []
    };
  },
  mounted() {
    this.loadCategories();
  },
  methods: {
    loadCategories() {
      CategoryService.getCategories()
      .then((response) => {
        this.categories = response.data;
      })
      .catch((error) => {
        alert(error);
      })
    },
    setCurrentNegativePostit(postit) {
      this.currentNegativePostit = postit;
    },
    setCurrentPositivePostit(postit) {
      this.currentPositivePostit = postit;
    },
    createPostit(postit) {
      PostitService.createPostit(postit)
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        alert(error);
      })
    }
  }
};
</script>
