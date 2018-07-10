<template>
  <div align="center">
    <div class="row">
      <div class="col s1">
        <div v-for="(positivePostit, index) in positivePostits">
          <a href="#" @click="setCurrentPositivePostit(positivePostit)">{{ index }}</a>
        </div>
        <a href="#" @click="newPositivePostit()">+</a>
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
                <button class="btn waves-effect waves-light red lighten-2" @click="removePositivePostit(currentPositivePostit.id)">
                  Remover
                  <i class="material-icons right">delete</i>
                </button>
              </div>
              <div class="col s6">
                <button class="btn waves-effect waves-light" @click="editPositivePostit(currentPositivePostit)">
                  Editar
                  <i class="material-icons right">edit</i>
                </button>
              </div>
            </div>
            <div v-else>
              <button class="btn waves-effect waves-light" @click="createPostit(currentPositivePostit)">
                Adicionar
                <i class="material-icons right">add</i>
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
        <div class="row">
          <div class="col s12">
            <div v-if="currentNegativePostit.id">
              <div class="col s6">
                <button class="btn waves-effect waves-light red lighten-2" @click="removeNegativePostit(currentNegativePostit.id)">
                  Remover
                  <i class="material-icons right">delete</i>
                </button>
              </div>
              <div class="col s6">
                <button class="btn waves-effect waves-light" @click="editNegativePostit(currentNegativePostit)">
                  Editar
                  <i class="material-icons right">edit</i>
                </button>
              </div>
            </div>
            <div v-else>
              <button class="btn waves-effect waves-light" @click="createPostit(currentNegativePostit)">
                Adicionar
                <i class="material-icons right">add</i>
              </button>
            </div>
          </div>
        </div>
      </div>
      <div class="col s1">
        <div v-for="(negativePostit, index) in negativePostits">
          <a href="#" @click="setCurrentNegativePostit(negativePostit)">{{ index }}</a>
        </div>
        <a href="#" @click="newNegativePostit()">+</a>
      </div>
    </div>
    <div class="row">
      <div class="col s12">
        <button class="btn waves-effect waves-light" @click="finish()">
          Finalizar
          <i class="material-icons right">done</i>
        </button>
      </div>
    </div>
  </div>
</template>
<script>
import CategoryService from '../services/category-service';
import PostitService from '../services/postit-service';
import UserService from '../services/user-service';
import { Socket } from 'phoenix-socket';

export default {
  data() {
    return {
      currentPositivePostit: {
        category_id: '', description: '', closure_id: parseInt(this.$route.params.id), positive: true
      },
      currentNegativePostit: {
        category_id: '', description: '', closure_id: parseInt(this.$route.params.id), positive: false
      },
      closureId: parseInt(this.$route.params.id),
      positivePostits: [],
      negativePostits: [],
      categories: [],
      channel: null,
      userId: null
    };
  },
  mounted() {
    this.getUserId();
    this.loadCategories();
    this.loadPositivePostits(this.closureId);
    this.loadNegativePostits(this.closureId);
  },
  methods: {
    getUserId() {
      UserService.getUserId()
      .then((response) => {
        this.userId = response.data;
        this.connectToSocket();
      })
      .catch((error) => {
        alert(error);
      })
    },
    connectToSocket() {
      // Connect to the websocket server
      let socket = new Socket("/socket");
      socket.connect();
       // Join in the links channel
      this.channel = socket.channel(`closure:${this.closureId}`, { user_id: this.userId });
      this.channel.join()
      .receive("ok", resp => { console.log("NewLink Joined successfully", resp) })
      .receive("error", resp => { console.log("NewLink Unable to join", resp) })
    },
    finish() {
      this.channel.push("closure:finished", { user_id: this.userId });
      // fazer o push para a proxima rota
    },
    editPositivePostit(postit) {
      PostitService.editPostit(postit)
      .then((response) => {
        this.loadPositivePostits(this.closureId);
        this.currentPositivePositit = response.data;
      })
      .catch((error) => {
        alert(error);
      })
    },
    editNegativePostit(postit) {
      PostitService.editPostit(postit)
      .then((response) => {
        this.loadNegativePostits(this.closureId);
        this.currentNegativePositit = response.data;
      })
      .catch((error) => {
        alert(error);
      })
    },
    loadNegativePostits(closureId) {
      PostitService.getPostits(closureId, false)
      .then((response) => {
        this.negativePostits = response.data;
      })
      .catch((error) => {
        alert(error)
      })
    },
    loadPositivePostits(closureId) {
      PostitService.getPostits(closureId, true)
      .then((response) => {
        this.positivePostits = response.data;
      })
      .catch((error) => {
        alert(error)
      })
    },
    removeNegativePostit(postitId) {
      PostitService.removePostit(postitId)
      .then((response) => {
        this.loadNegativePostits(this.closureId);
        this.newNegativePostit();
      })
      .catch((error) => {
        alert(error);
      })
    },
    removePositivePostit(postitId) {
      PostitService.removePostit(postitId)
      .then((response) => {
        this.loadPositivePostits(this.closureId);
        this.newPositivePostit();
      })
      .catch((error) => {
        alert(error);
      })
    },
    addPositivePostit(postit) {
      this.positivePostits.push(postit);
    },
    addNegativePostit(postit) {
      this.negativePostits.push(postit);
    },
    newPositivePostit() {
      this.currentPositivePostit = {
        category_id: '', description: '', closure_id: parseInt(this.$route.params.id), positive: true
      };
    },
    newNegativePostit() {
      this.currentNegativePostit = {
        category_id: '', description: '', closure_id: parseInt(this.$route.params.id), positive: false
      };
    },
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
        const postit = response.data;
        if(postit.positive) {
          this.addPositivePostit(postit);
          this.newPositivePostit();
        } else {
          this.addNegativePostit(postit);
          this.newNegativePostit();
        }
      })
      .catch((error) => {
        alert(error);
      })
    }
  }
};
</script>
