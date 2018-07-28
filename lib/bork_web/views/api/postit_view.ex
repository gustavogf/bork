defmodule BorkWeb.Api.PostitView do
  use BorkWeb, :view
  require IEx

  def render("index.json", %{ postits: postits }) do
    Enum.map(postits, &postit_json/1)
  end

  def render("create.json", %{ postit: postit }) do
    postit_json(postit)
  end

  def render("summary_postit.json", %{ positive: positive, negative: negative }) do
    %{
      positive: generate_summary(positive),
      negative: generate_summary(negative)
    }
  end

  def generate_summary(aggrouped_categories) do
    %{
      total: sum_total(aggrouped_categories),
      data: generate_summary_data(aggrouped_categories)
    }
  end

  def sum_total(aggrouped_categories) do
    map_length(aggrouped_categories)
    |> Enum.sum
  end

  def map_length(data) do
    Enum.map(data, fn(i) -> length(i.postits) end)
  end

  def generate_summary_data(aggrouped_categories) do
    Enum.map(aggrouped_categories, fn(p) ->
      %{
        category: p.name,
        postits: Enum.map(p.postits, &postit_json/1),
        total: length(p.postits)
      }
    end)
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
