defmodule Bork.Repo.Migrations.CreatePostits do
  use Ecto.Migration

  def change do
    create table(:postits) do
      add :description, :string
      add :positive, :boolean
      add :category_id, references(:categories)
      add :sprint_id, references(:sprints)
      add :squad_id, references(:squads)

      timestamps()
    end

  end
end
