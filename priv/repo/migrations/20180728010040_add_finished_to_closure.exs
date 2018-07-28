defmodule Bork.Repo.Migrations.AddFinishedToClosure do
  use Ecto.Migration

  def change do
    alter table(:closures) do
      add :finished, :boolean, default: false
    end
  end
end
