defmodule BorkWeb.Api.UserView do
  use BorkWeb, :view

  def render("create.json", %{user: user}) do
    user_json(user)
  end

  def user_json(user) do
    %{
      id: user.id,
      name: user.name
    }
  end
end
