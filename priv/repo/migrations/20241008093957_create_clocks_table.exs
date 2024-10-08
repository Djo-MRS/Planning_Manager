defmodule Timemanager.Repo.Migrations.CreateClocksTable do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :times, :utc_datetime
      add :status, :boolean, default: false
      add :user, :string

      timestamps(type: :utc_datetime)
    end
  end
end
