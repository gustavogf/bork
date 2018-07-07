defmodule BorkWeb.Api.SprintView do
  use BorkWeb, :view

  def render("index.json", %{sprints: sprints}) do
    Enum.map(sprints, &sprint_json/1)
  end

  def sprint_json(sprint) do
    %{
      id: sprint.id,
      name: sprint.name
    }
  end
end
