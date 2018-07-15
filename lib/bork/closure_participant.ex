defmodule Bork.ClosureParticipant do
  use Ecto.Schema
  import Ecto.Changeset


  schema "closure_participants" do
    field :finished, :boolean
    belongs_to :user, Bork.User
    belongs_to :closure, Bork.Closure
    timestamps()
  end

  @doc false
  def changeset(closure_participant, attrs) do
    closure_participant
    |> cast(attrs, [:finished, :user, :closure])
    |> validate_required([:finished, :user, :closure])
  end
end
