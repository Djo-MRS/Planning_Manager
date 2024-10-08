defmodule Timemanager.Repo.Migrations.AddUserIdToClocks do
  use Ecto.Migration

  def change do
    alter table(:clocks) do
      add :user_id, references(:users, on_delete: :nothing)
    end

    create index(:clocks, [:user_id])
  end
end
