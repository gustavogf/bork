class SquadService {
  getSquads() {
    let url = '/api/squads';
    return Vue.http.get(url);
  }
}

export default new SquadService();
