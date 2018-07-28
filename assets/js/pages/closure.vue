<template>
  <div align="center">
    <div v-if="currentUser.id">
      <div v-if="!userFinished">
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
        <div class="row">
          <div class="s4 offset-4">
            <h5>Online:</h5>
            <div v-for="user in onlineUsers">
              {{ user.name }}
            </div>
          </div>
        </div>
      </div>
      <div v-else>
        Esperando os outros terminarem
      </div>
    </div>
    <div class="row" v-else>
      <h4>Quem é você?</h4>
      <div class="col s6 offset-s3">
        <div class="row">
          <div class="input-field col s12">
            <input v-model="userName" placeholder="Primeiro nome" id="first_name" type="text" class="validate">
            <label for="first_name">Nome</label>
          </div>
        </div>
        <div class="row">
          <button class="btn waves-effect waves-light" @click="configureName(userName)">Partiu
            <i class="material-icons right">send</i>
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
</template>
<script>
import CategoryService from '../services/category-service';
import PostitService from '../services/postit-service';
import UserService from '../services/user-service';
import ClosureService from '../services/closure-service';
import {Socket, Presence} from "phoenix";

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
      currentUser: {},
      userName: '',
      presences: {},
      onlineUsers: [],
      userFinished: null,
      closureFinished: null,
    };
  },
  mounted() {
    this.checkIfClosureIsFinished();
  },
  methods: {
    checkIfClosureIsFinished(){
      ClosureService.checkIfClosureIsFinished(this.closureId)
      .then((response) => {
        this.closureFinished = response.data.finished;
        if(this.closureFinished) {
          this.goToSummary();
        } else {
          this.fetchCurrentUser();
          this.loadCategories();
        }
      })
      .catch((error) => {
        alert('Erro ao checar se o fechamento ja terminou');
      })
    },
    fetchCurrentUser() {
      UserService.getCurrentUser()
      .then((response) => {
        this.currentUser = response.data;
        if(this.currentUser.id) {
          this.loadPositivePostits(this.closureId);
          this.loadNegativePostits(this.closureId);
          this.connectToSocket();
        }
      })
      .catch((error) => {
        alert('Erro no get current user');
      })
    },
    configureName(userName) {
      UserService.newUser(userName)
      .then((response) => {
        this.currentUser = response.data;
        this.connectToSocket();
      })
      .catch((error) => {
        alert('Erro ao configurar nome');
      })
    },
    connectToSocket() {
      // Connect to the websocket server
      let socket = new Socket("/socket");
      socket.connect();
      // Join in the links channel
      this.channel = socket.channel(`closure:${this.closureId}`, { user_bork_id: this.currentUser.id });
      this.channel.join()
      .receive("ok", resp => { console.log("NewLink Joined successfully", resp) })
      .receive("error", resp => { console.log("NewLink Unable to join", resp) });

      this.channel.on("presence_state", state => {
        this.presences = Presence.syncState(this.presences, state);
        this.renderOnlineUsers(this.presences);
      });

      this.channel.on("presence_diff", diff => {
        this.presences = Presence.syncDiff(this.presences, diff);
        this.renderOnlineUsers(this.presences);
      });

      this.channel.on('closure:done', () => {
        this.goToSummary();
      });
    },
    renderOnlineUsers() {
      this.onlineUsers = [];
      Presence.list(this.presences).map(p => {
        if(p.metas) {
          this.onlineUsers.push(p.metas[0]);
        }
      });
    },
    goToSummary() {
      this.$router.push({ name: 'closure_summary', params: { closureId: this.closureId } });
    },
    finish() {
      this.userFinished = true;
      this.channel.push('closure:finished');
    },
    editPositivePostit(postit) {
      PostitService.editPostit(postit)
      .then((response) => {
        this.loadPositivePostits(this.closureId);
        this.currentPositivePositit = response.data;
      })
      .catch((error) => {
        alert('Erro ao editar postit positivo');
      })
    },
    editNegativePostit(postit) {
      PostitService.editPostit(postit)
      .then((response) => {
        this.loadNegativePostits(this.closureId);
        this.currentNegativePositit = response.data;
      })
      .catch((error) => {
        alert('Erro ao editar postit negativo');
      })
    },
    loadNegativePostits(closureId) {
      PostitService.getPostits(closureId, false, this.currentUser.id)
      .then((response) => {
        this.negativePostits = response.data;
      })
      .catch((error) => {
        alert('Erro ao carregar os postits negativos');
      })
    },
    loadPositivePostits(closureId) {
      PostitService.getPostits(closureId, true, this.currentUser.id)
      .then((response) => {
        this.positivePostits = response.data;
      })
      .catch((error) => {
        alert('Erro ao carregar postits positivos');
      })
    },
    removeNegativePostit(postitId) {
      PostitService.removePostit(postitId)
      .then((response) => {
        this.loadNegativePostits(this.closureId);
        this.newNegativePostit();
      })
      .catch((error) => {
        alert('Erro ao remover postit negativo');
      })
    },
    removePositivePostit(postitId) {
      PostitService.removePostit(postitId)
      .then((response) => {
        this.loadPositivePostits(this.closureId);
        this.newPositivePostit();
      })
      .catch((error) => {
        alert('Erro ao remover postit positivo');
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
        alert('Erro ao carregar categorias dos postits');
      })
    },
    setCurrentNegativePostit(postit) {
      this.currentNegativePostit = postit;
    },
    setCurrentPositivePostit(postit) {
      this.currentPositivePostit = postit;
    },
    createPostit(postit) {
      PostitService.createPostit(postit, this.currentUser.id)
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
        alert('Erro ao criar postits');
      })
    }
  }
};
</script>
