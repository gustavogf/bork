class UserService {
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
