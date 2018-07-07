class SprintService {
  getSprints() {
    let url = '/api/sprints';
    return Vue.http.get(url);
  }
}

export default new SprintService();
