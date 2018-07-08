defmodule BorkWeb.Api.CategoryController do
  use BorkWeb, :controller
  alias Bork.Category
  alias Bork.Repo

  def index(conn, _params) do
    categories = Repo.all(Category)
    render conn, "index.json", categories: categories
  end
end
