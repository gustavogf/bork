defmodule Bork.Repo.Migrations.CreateClosureParticipants do
  use Ecto.Migration

  def change do
    create table(:closure_participants) do
      add :user_id, references(:users)
      add :closure_id, references(:closures)
      add :finished, :boolean, default: false
      timestamps()
    end

    create unique_index(:closure_participants, [:user_id, :closure_id])
  end
end
