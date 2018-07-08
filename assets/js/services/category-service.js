class CategoryService {
  getCategories() {
    let url = '/api/categories';
    return Vue.http.get(url);
  }
}

export default new CategoryService();
