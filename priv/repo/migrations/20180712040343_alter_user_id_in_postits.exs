defmodule Bork.Repo.Migrations.AlterUserIdInPostits do
  use Ecto.Migration

  def change do
    alter table(:postits) do
      remove :user_id
      add :user_id, references(:users)
    end
  end
end
