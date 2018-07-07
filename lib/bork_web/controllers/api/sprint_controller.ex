defmodule BorkWeb.Api.SprintController do
  use BorkWeb, :controller
  alias Bork.Sprint
  alias Bork.Repo

  def index(conn, _params) do
    sprints = Repo.all(Sprint)
    render conn, "index.json", sprints: sprints
  end
end
