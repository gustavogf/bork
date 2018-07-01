defmodule Bork.Postit do
  use Ecto.Schema
  import Ecto.Changeset


  schema "postits" do
    field :description, :string
    field :positive, :boolean
    belongs_to :category, Bork.Category
    belongs_to :sprint, Bork.Sprint
    belongs_to :squad, Bork.Squad

    timestamps()
  end

  @doc false
  def changeset(postit, attrs) do
    postit
    |> cast(attrs, [:description, :positive, :category, :sprint, :squad])
    |> validate_required([:description, :positive, :category, :sprint, :squad])
  end
end
