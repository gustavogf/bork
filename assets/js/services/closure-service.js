class ClosureService {
  createClosure(squadId, sprintId) {
    let url = '/api/closures';
    return Vue.http.post(url, { squad_id: squadId, sprint_id: sprintId });
  }
}

export default new ClosureService();
