defmodule BorkWeb.Api.PostitView do
  use BorkWeb, :view

  def render("create.json", %{ postit: postit }) do
    postit_json(postit)
  end

  def postit_json(postit) do
    %{
      id: postit.id,
      category_id: postit.category_id,
      closure_id: postit.closure_id,
      description: postit.description,
      positive: postit.positive
    }
  end
end
