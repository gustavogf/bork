defmodule BorkWeb.Api.CategoryView do
  use BorkWeb, :view

  def render("index.json", %{ categories: categories }) do
    Enum.map(categories, &category_json/1)
  end

  def category_json(category) do
    %{
      id: category.id,
      name: category.name
    }
  end
end
