defmodule Timemanager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :firstname, :string
      add :lastname, :string
      add :email, :string
      add :password_hash, :string
      add :role_id, references(:roles, on_delete: :nothing), null: false, default: 1
      timestamps(type: :utc_datetime)

  end
    end
end
