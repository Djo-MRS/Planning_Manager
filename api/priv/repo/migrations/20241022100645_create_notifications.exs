defmodule Timemanager.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :title, :string
      add :message, :text
      add :date, :naive_datetime
      add :sender_id, references(:users, on_delete: :nothing)
      add :receiver_id, references(:users, on_delete: :nothing)

      timestamps()
    end
  end
end
