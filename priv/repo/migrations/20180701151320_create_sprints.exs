defmodule Bork.Repo.Migrations.CreateSprints do
  use Ecto.Migration

  def change do
    create table(:sprints) do
      add :name, :string
      timestamps()
    end

    create unique_index(:sprints, :name)
  end
end
