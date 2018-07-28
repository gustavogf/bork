defmodule Bork.Closure do
  use Ecto.Schema
  import Ecto.Changeset

  schema "closures" do
    field :finished, :boolean
    belongs_to :sprint, Bork.Sprint
    belongs_to :squad, Bork.Squad
    has_many :postits, Bork.Postit
    has_many :closure_participants, Bork.ClosureParticipant
    timestamps()
  end

  @doc false
  def changeset(closure, attrs) do
    closure
    |> cast(attrs, [:sprint, :squad, :finished])
    |> validate_required([:sprint, :squad, :finished])
  end
end
