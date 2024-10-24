defmodule Timemanager.UserTeam do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_teams" do
    field :user_id, :id
    field :team_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_team, attrs) do
    user_team
    |> cast(attrs, [:user_id, :team_id])
    |> validate_required([:user_id, :team_id])
    |> foreign_key_constraint(:user_id, name: "user_teams_user_id_fkey")
    |> foreign_key_constraint(:team_id, name: "user_teams_team_id_fkey")
  end
end
