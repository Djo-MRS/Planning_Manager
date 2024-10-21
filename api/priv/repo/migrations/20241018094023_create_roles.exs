defmodule Timemanager.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :label, :string, null: false

      timestamps()
    end

    create unique_index(:roles, [:label])

    # Ajout de la colonne role_id dans la table users pour la relation avec le rôle
    alter table(:users) do
      add :role_id, references(:roles, on_delete: :nothing)
    end
  end
end
