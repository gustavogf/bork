class PostitService {
  createPostit(postit) {
    let url = '/api/postits';
    return Vue.http.post(url, { postit: postit });
  }

  editPostit(postit) {
    let url = `/api/postits/${postit.id}`;
    return Vue.http.put(url, { postit: postit });
  }

  removePostit(postitId) {
    let url = `/api/postits/${postitId}`;
    return  Vue.http.delete(url);
  }

  getPostits(closureId, positive) {
    let url = '/api/postits';
    return Vue.http.get(url, { params: { closure_id: closureId, positive: positive } })
  }
}

export default new PostitService();
