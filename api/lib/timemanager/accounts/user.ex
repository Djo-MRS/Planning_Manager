defmodule Timemanager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bcrypt

  schema "users" do
    field :name, :string
    field :surname, :string
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :role, :string, default: "user"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :surname, :email, :password])
    |> validate_required([:name, :surname, :email, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> hash_password()
  end


  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      change(changeset, password_hash: Bcrypt.hash_pwd_salt(password))
    else
      changeset
    end
  end
end
