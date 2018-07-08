defmodule Bork.Repo.Migrations.AddUserIdToPostits do
  use Ecto.Migration

  def change do
    alter table(:postits) do
      add :user_id, :string
    end
  end
end
