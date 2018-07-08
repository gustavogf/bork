defmodule BorkWeb.Api.ClosureController do
  use BorkWeb, :controller
  alias Bork.Closure
  alias Bork.Repo

  def create(conn, %{ "squad_id" => squad_id, "sprint_id" => sprint_id } = params) do
    closure = Repo.get_by(Closure, sprint_id: sprint_id, squad_id: squad_id)
    if !closure do
      closure = Repo.insert!(%Closure{ sprint_id: sprint_id, squad_id: squad_id })
    end
    json conn, closure.id
  end
end
