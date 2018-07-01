defmodule Bork.Repo.Migrations.CreateSquads do
  use Ecto.Migration

  def change do
    create table(:squads) do
      add :name, :string
      timestamps()
    end

    create unique_index(:squads, :name)
  end
end
