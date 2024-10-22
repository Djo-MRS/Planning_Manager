defmodule Timemanager.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name]}
  schema "roles" do
    field :name, :string
    has_many :users, Timemanager.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
