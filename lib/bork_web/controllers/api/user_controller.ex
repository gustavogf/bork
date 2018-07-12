defmodule BorkWeb.Api.UserController do
  use BorkWeb, :controller
  require IEx
  alias Bork.{User, Repo}

  def current_user(conn, _params) do
    conn = fetch_session(conn)
    user_id = get_session(conn, :user_bork_id)
    if user_id do
      user = Repo.get!(User, user_id)
      render conn, "create.json", user: user
    else
      render conn, "empty.json", %{}
    end
  end

  def create(conn, %{ "name" => name }) do
    conn = fetch_session(conn)
    changeset = %User{name: name}
    user = Repo.insert!(changeset)
    conn = put_session(conn, :user_bork_id, user.id)
    render conn, "create.json", user: user
  end
end
