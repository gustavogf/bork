defmodule BorkWeb.Api.SquadController do
  use BorkWeb, :controller
  alias Bork.Squad
  alias Bork.Repo

  def index(conn, _params) do
    squads = Repo.all(Squad)
    render conn, "index.json", squads: squads
  end
end
