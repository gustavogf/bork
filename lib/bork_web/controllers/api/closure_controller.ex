defmodule BorkWeb.Api.ClosureController do
  use BorkWeb, :controller
  alias Bork.Closure
  require IEx
  alias Bork.Repo

  def create(conn, %{ "squad_id" => squad_id, "sprint_id" => sprint_id }) do
    closure = Repo.get_by(Closure, sprint_id: sprint_id, squad_id: squad_id)
    if !closure do
      closure = Repo.insert!(%Closure{ sprint_id: sprint_id, squad_id: squad_id })
    end
    json conn, closure.id
  end

  def finished(conn, %{ "id" => id }) do
    closure = Repo.get(Closure, id)
    if !closure do
      json conn, %{ finished: false }
    else
      json conn, %{ finished: closure.finished }
    end
  end
end
