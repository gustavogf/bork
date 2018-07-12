defmodule Bork.Postit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "postits" do
    field :description, :string
    field :positive, :boolean
    belongs_to :category, Bork.Category
    belongs_to :closure, Bork.Closure
    belongs_to :user, Bork.User
    timestamps()
  end

  @doc false
  def changeset(postit, attrs) do
    postit
    |> cast(attrs, [:description, :positive, :category, :closure, :user])
    |> validate_required([:description, :positive, :category, :closure, :user])
  end
end
