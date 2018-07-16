defmodule BorkWeb.Api.UserView do
  use BorkWeb, :view
  require IEx

  def render("empty.json", %{}) do
    %{}
  end

  def render("create.json", %{ user: user }) do
    user_json(user)
  end

  def user_json(user) do
    %{
      id: user.id,
      name: user.name
    }
  end
end
