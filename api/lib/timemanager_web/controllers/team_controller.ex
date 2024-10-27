defmodule TimemanagerWeb.TeamController do
  use TimemanagerWeb, :controller

  alias Timemanager.Teams
  alias Timemanager.Teams.Team
  alias Timemanager.Accounts.User
  alias Timemanager.UserTeams

  action_fallback TimemanagerWeb.FallbackController

  defp clean_id(id) when is_binary(id), do: String.trim(id)
  defp clean_id(id), do: id

  def index(conn, _params) do
    teams = Teams.list_teams()
    render(conn, :index, teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    with {:ok, %Team{} = team} <- Teams.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/teams/#{team.id}")
      |> render(:show, team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Teams.get_team!(clean_id(id))
    render(conn, :show, team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Teams.get_team!(clean_id(id))

    with {:ok, %Team{} = team} <- Teams.update_team(team, team_params) do
      render(conn, :show, team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Teams.get_team!(clean_id(id))

    with {:ok, %Team{}} <- Teams.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end

  def add_user_to_team(conn, %{"team_id" => team_id, "user_id" => user_id}) do
    case UserTeams.add_user_to_team(user_id, team_id) do
      {:ok, _user_team} ->
        conn
        |> put_status(:ok)
        |> json(%{message: "User added to team successfully."})

      {:error, :already_in_team} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "User is already in this team"})

      {:error, _reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Unable to add user to team"})
    end
  end



  def remove_user_from_team(conn, %{"team_id" => team_id, "user_id" => user_id}) do
    with {:ok, _user_team} <- UserTeams.remove_user_from_team(clean_id(user_id), clean_id(team_id)) do
      conn
      |> put_status(:ok)
      |> json(%{message: "User removed from team successfully."})
    else
      {:error, :not_found} -> conn |> put_status(:not_found) |> json(%{error: "User not found in team"})
      {:error, _reason} -> conn |> put_status(:bad_request) |> json(%{error: "Unable to remove user from team"})
    end
  end
end
