class UserService {
  checkIfUserFinished(userId, closureId) {
    let url = `/api/user-finished`;
    return Vue.http.get(url, { params: { user_id: userId, closure_id: closureId } });
  }

  newUser(userName){
    let url = '/api/user';
    return Vue.http.post(url, { name: userName });
  }

  getCurrentUser() {
    let url = '/api/current-user';
    return Vue.http.get(url);
  }
}

export default new UserService();
