class ClosureService {
  createClosure(squadId, sprintId) {
    let url = '/api/closures';
    return Vue.http.post(url, { squad_id: squadId, sprint_id: sprintId });
  }

  checkIfClosureIsFinished(closureId) {
    let url = `/api/closure/${closureId}/finished`
    return Vue.http.get(url);
  }
}

export default new ClosureService();
