defmodule BorkWeb.Api.UserController do
  use BorkWeb, :controller

  def index(conn, _params) do
    conn = fetch_session(conn)
    user_id = get_session(conn, :user_bork_id)
    if !user_id do
      user_id = Ecto.UUID.generate()
      conn = put_session(conn, :user_bork_id, user_id)
    end
    json conn, user_id
  end
end
