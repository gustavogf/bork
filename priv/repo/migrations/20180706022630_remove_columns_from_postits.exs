defmodule Bork.Repo.Migrations.RemoveColumnsFromPostits do
  use Ecto.Migration

  def change do
    alter table(:postits) do
      remove :squad_id
      remove :sprint_id
      add :closure_id, references(:closures)
    end
  end
end
