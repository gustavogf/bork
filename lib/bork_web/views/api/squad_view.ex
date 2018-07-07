defmodule BorkWeb.Api.SquadView do
  use BorkWeb, :view

  def render("index.json", %{squads: squads}) do
    Enum.map(squads, &squad_json/1)
  end

  def squad_json(squad) do
    %{
      id: squad.id,
      name: squad.name
    }
  end
end
