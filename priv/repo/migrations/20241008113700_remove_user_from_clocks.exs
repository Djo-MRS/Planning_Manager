defmodule Timemanager.Repo.Migrations.RemoveUserFromClocks do
  use Ecto.Migration

  def change do
    alter table(:clocks) do
      remove :user
    end
  end
end
