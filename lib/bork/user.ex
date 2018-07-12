defmodule Bork.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :name, :string
    has_many :postits, Bork.Postit
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
