class PostitService {
  createPostit(postit) {
    let url = '/api/postits';
    return Vue.http.post(url, { postit: postit });
  }
}

export default new PostitService();
