defmodule BorkWeb.Api.PostitController do
  use BorkWeb, :controller
  alias Bork.{Postit, Repo, Category, Closure}

  def create(conn, %{ "postit" => postit } = params) do
    category = Repo.get(Category, postit["category_id"])
    closure = Repo.get(Closure, postit["closure_id"])
    changeset = %Postit{
      category: category,
      closure: closure,
      description: postit["description"],
      positive: postit["positive"]
    }
    postit = Repo.insert!(changeset)
    render conn, "create.json", postit: postit
  end
end
