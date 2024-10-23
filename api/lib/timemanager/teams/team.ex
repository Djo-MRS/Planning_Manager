defmodule Timemanager.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    field :description, :string

    many_to_many :users, Timemanager.Accounts.User, join_through: "user_teams"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
