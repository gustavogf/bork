defmodule BorkWeb.Api.UserController do
  use BorkWeb, :controller
  require IEx
  alias Bork.{User, Repo, ClosureParticipant}
  require Logger

  def user_finished(conn, %{ closure_id: closure_id }) do
    conn = fetch_session(conn)
    user_id = get_session(conn, :user_bork_id)
    participant = Repo.get_by(ClosureParticipant, user_id: user_id, closure_id: closure_id)
    if participant do
      json conn, %{ finished: participant.finished }
    else
      json conn, %{}
    end
  end

  def current_user(conn, _params) do
    conn = fetch_session(conn)
    user_id = get_session(conn, :user_bork_id)
    if user_id do
      user = Repo.get(User, user_id)
      if user do
        render conn, "create.json", user: user
      else
        render conn, "empty.json", %{}
      end
    else
      render conn, "empty.json", %{}
    end
  end

  def create(conn, %{ "name" => name }) do
    conn = fetch_session(conn)
    changeset = %User{ name: name }
    { :ok, user } = Repo.insert(changeset)
    conn = put_session(conn, :user_bork_id, user.id)

    render conn, "create.json", user: user
  end
end
