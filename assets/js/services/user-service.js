class UserService {
  getUserId(){
    let url = '/api/user-id';
    return Vue.http.get(url);
  }
}

export default new UserService();
