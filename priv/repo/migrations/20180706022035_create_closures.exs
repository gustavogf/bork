defmodule Bork.Repo.Migrations.CreateClosures do
  use Ecto.Migration

  def change do
    create table(:closures) do
      add :sprint_id, references(:sprints)
      add :squad_id, references(:squads)
      timestamps()
    end
    create unique_index(:closures, [:sprint_id, :squad_id])
  end
end
