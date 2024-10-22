defmodule Timemanager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :firstname, :lastname, :email]}  # Déplacement avant le bloc schema
  schema "users" do
    field :firstname, :string
    field :lastname, :string
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    belongs_to :role, Timemanager.Accounts.Role, foreign_key: :role_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :email, :password, :role_id])  # Utilise :role_id
    |> validate_required([:firstname, :lastname, :email, :password, :role_id])  # Ajoute :role_id
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> assoc_constraint(:role)
    |> hash_password()
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      change(changeset, password_hash: Argon2.hash_pwd_salt(password))
    else
      changeset
    end
  end
end
