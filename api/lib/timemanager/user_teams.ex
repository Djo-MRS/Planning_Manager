defmodule Timemanager.UserTeams do
  alias Timemanager.Repo
  alias Timemanager.UserTeam

  # Ajoute un utilisateur à une équipe
  def add_user_to_team(user_id, team_id) do
    # Vérifie si l'utilisateur est déjà dans l'équipe
    case Repo.get_by(UserTeam, user_id: user_id, team_id: team_id) do
      nil ->
        %UserTeam{}
        |> UserTeam.changeset(%{user_id: user_id, team_id: team_id})
        |> Repo.insert()
      _user_team ->
        {:error, :already_in_team}
    end
  end

  # Supprime un utilisateur d'une équipe
  def remove_user_from_team(user_id, team_id) do
    Repo.get_by(UserTeam, user_id: user_id, team_id: team_id)
    |> case do
      nil -> {:error, :not_found}
      user_team -> Repo.delete(user_team)
    end
  end
end
