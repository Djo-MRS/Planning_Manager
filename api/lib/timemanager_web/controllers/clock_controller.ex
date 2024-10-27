defmodule TimemanagerWeb.ClockController do
  use TimemanagerWeb, :controller

  alias Timemanager.Clocking
  alias Timemanager.Clocking.Clock
  alias Timemanager.Accounts
  alias Timemanager.Repo

  action_fallback TimemanagerWeb.FallbackController

  def get_token(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] -> {:ok, token}
      _ -> get_jwt_from_cookies(conn)
    end
  end

  defp get_jwt_from_cookies(conn) do
    case conn.cookies["jwt"] do
      nil -> {:error, "No token provided"}
      token -> {:ok, token}
    end
  end

  def get_by_user(conn, %{"userID" => user_id}) do
    case get_token(conn) do
      {:ok, token} ->
        signer = Joken.Signer.create("HS256", System.get_env("JWT_SECRET") || "batman")

        case Joken.verify(token, signer) do
          {:ok, _claims} ->
            case Accounts.get_user(user_id) do
              nil ->
                conn
                |> put_status(:not_found)
                |> json(%{error: "Utilisateur non trouvé"})

              _user -> 
                user = Repo.preload(Accounts.get_user(user_id), :role)
                clocks = Clocking.get_clocks_by_user(user_id)
                clocks = Repo.preload(clocks, :user)
                render(conn, :index, clocks: clocks)
            end

          {:error, reason} ->
            conn
            |> put_status(:unauthorized)
            |> json(%{error: reason})
        end

      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "No token provided"})
    end
  end

  def create_for_user(conn, %{"userID" => user_id, "clock" => clock_params}) do
    IO.inspect(conn.cookies, label: "Cookies in POST request")
    IO.inspect(get_req_header(conn, "authorization"), label: "Authorization header in POST request")

    case get_token(conn) do
      {:ok, token} ->
        signer = Joken.Signer.create("HS256", System.get_env("JWT_SECRET") || "batman")

        case Joken.verify(token, signer) do
          {:ok, _claims} ->
            case Accounts.get_user(user_id) do
              nil ->
                conn
                |> put_status(:not_found)
                |> json(%{error: "Utilisateur non trouvé"})

              _user ->
                clock_params = Map.put(clock_params, "user_id", user_id)

                with {:ok, %Clock{} = clock} <- Clocking.create_clock(clock_params) do
                  conn
                  |> put_status(:created)
                  |> put_resp_header("location", ~p"/api/clocks/#{clock.id}")
                  |> render("show.json", clock: clock)
                else
                  {:error, %Ecto.Changeset{} = changeset} ->
                    conn
                    |> put_status(:unprocessable_entity)
                    |> render("error.json", changeset: changeset)
                end
            end

          {:error, reason} ->
            conn
            |> put_status(:unauthorized)
            |> json(%{error: reason})
        end

      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "No token provided"})
    end
  end
end
