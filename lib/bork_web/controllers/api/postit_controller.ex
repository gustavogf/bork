defmodule BorkWeb.Api.PostitController do
  import Ecto.Query
  use BorkWeb, :controller
  alias Bork.{Postit, Repo, Category, Closure}

  def index(conn, %{ "closure_id" => closure_id, "positive" => positive } = params) do
    conn = fetch_session(conn)
    user_id = get_session(conn, :user_bork_id)
    if !user_id do
      user_id = Ecto.UUID.generate()
      conn = put_session(conn, :user_bork_id, user_id)
    end

    query = from p in Postit,
            where: p.user_id == ^user_id and p.closure_id == ^closure_id and p.positive == ^positive
    postits = Repo.all(query)
    render conn, "index.json", postits: postits
  end

  def delete(conn, %{ "id" => id } =params) do
    postit = Repo.get!(Postit, id)
    Repo.delete!(postit)
    json conn, 'ok'
  end

  def create(conn, %{ "postit" => postit } = params) do
    category = Repo.get(Category, postit["category_id"])
    closure = Repo.get(Closure, postit["closure_id"])

    conn = fetch_session(conn)
    user_id = get_session(conn, :user_bork_id)
    if !user_id do
      user_id = Ecto.UUID.generate()
      conn = put_session(conn, :user_bork_id, user_id)
    end

    changeset = %Postit{
      category: category,
      closure: closure,
      description: postit["description"],
      positive: postit["positive"],
      user_id: user_id
    }
    postit = Repo.insert!(changeset)
    render conn, "create.json", postit: postit
  end
end
