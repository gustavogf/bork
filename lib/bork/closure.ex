defmodule Bork.Closure do
  use Ecto.Schema
  import Ecto.Changeset

  schema "closures" do
    belongs_to :sprint, Bork.Sprint
    belongs_to :squad, Bork.Squad
    has_many :postits, Bork.Postit
    timestamps()
  end

  @doc false
  def changeset(closure, attrs) do
    closure
    |> cast(attrs, [:sprint, :squad])
    |> validate_required([:sprint, :squad])
  end
end
