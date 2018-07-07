defmodule Bork.Postit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "postits" do
    field :description, :string
    field :positive, :boolean
    belongs_to :category, Bork.Category
    belongs_to :closure, Bork.Closure
    timestamps()
  end

  @doc false
  def changeset(postit, attrs) do
    postit
    |> cast(attrs, [:description, :positive, :category, :closure])
    |> validate_required([:description, :positive, :category, :closure])
  end
end
