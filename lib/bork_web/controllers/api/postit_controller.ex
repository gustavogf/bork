defmodule BorkWeb.Api.PostitController do
  import Ecto.Query
  require IEx
  use BorkWeb, :controller
  alias Bork.{Postit, Repo, Category, Closure}

  def index(conn, %{ "closure_id" => closure_id, "positive" => positive, "user_id" => user_id }) do
    conn = fetch_session(conn)
    query = from p in Postit,
            where: p.user_id == ^user_id and p.closure_id == ^closure_id and p.positive == ^positive,
            order_by: [asc: p.id]

    postits = Repo.all(query)
    render conn, "index.json", postits: postits
  end

  def update(conn, %{ "id" => id, "postit" => postit }) do
    saved_postit = Repo.get!(Postit, id)
    |> Ecto.Changeset.change(%{ category_id: postit["category_id"], description: postit["description"] })
    |> Repo.update!
    render conn, "create.json", postit: saved_postit
  end

  def delete(conn, %{ "id" => id }) do
    postit = Repo.get!(Postit, id)
    Repo.delete!(postit)
    json conn, 'ok'
  end

  def create(conn, %{ "postit" => postit, "user_id" => user_id }) do
    category = Repo.get(Category, postit["category_id"])
    closure = Repo.get(Closure, postit["closure_id"])

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

  def summary_postits(conn, %{ "closure_id" => closure_id }) do
    postit_query_positive = from postit in Postit, where: postit.closure_id == ^closure_id and postit.positive == true

    positive_query = from c in Category,
                     join: p in assoc(c, :postits),
                     where: p.closure_id == ^closure_id and p.positive == true,
                     preload: [postits: ^postit_query_positive], group_by: c.id
    positive_postits = Repo.all(positive_query)

    postit_query_negative = from postit in Postit, where: postit.closure_id == ^closure_id and postit.positive == false
    negative_query = from c in Category,
                     join: p in assoc(c, :postits),
                     where: p.closure_id == ^closure_id and p.positive == false,
                     preload: [postits: ^postit_query_negative], group_by: c.id
    negative_postits = Repo.all(negative_query)

    render conn, "summary_postit.json", positive: positive_postits, negative: negative_postits
  end
end
