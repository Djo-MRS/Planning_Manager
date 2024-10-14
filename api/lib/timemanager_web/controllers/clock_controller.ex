defmodule TimemanagerWeb.ClockController do
  use TimemanagerWeb, :controller

  alias Timemanager.Clocking
  alias Timemanager.Clocking.Clock
  alias Timemanager.Accounts

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    clocks = Clocking.list_clocks()
    render(conn, :index, clocks: clocks)
  end

  def create_for_user(conn, %{"userID" => user_id, "clock" => clock_params}) do
    case Accounts.get_user(user_id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Utilisateur non trouvé"})

      _user ->
        clock_params = Map.put(clock_params, "user_id", user_id)

        last_clock = Clocking.get_clocks_by_user(user_id)
                    |> Enum.sort_by(& &1.inserted_at, :desc)
                    |> List.first()

        new_status =
          case last_clock do
            nil -> true
            %Clock{status: true} -> false
            %Clock{status: false} -> true
          end

        updated_clock_params = Map.put(clock_params, "status", new_status)

        with {:ok, %Clock{} = clock} <- Clocking.create_clock(updated_clock_params) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", ~p"/api/clocks/#{clock.id}")
          |> render(:show, clock: clock)
        else
          {:error, %Ecto.Changeset{} = changeset} ->
            errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
              Enum.reduce(opts, msg, fn {key, value}, acc -> String.replace(acc, "%{#{key}}", to_string(value)) end)
            end)

            conn
            |> put_status(:unprocessable_entity)
            |> json(%{errors: errors})

          _ ->
            conn
            |> put_status(:bad_request)
            |> json(%{error: "Données invalides"})
        end
    end
  end

  def get_by_user(conn, %{"userID" => user_id}) do
    case Accounts.get_user(user_id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Utilisateur non trouvé"})

      _user ->
        last_clock = Clocking.get_clocks_by_user(user_id)
                      |> Enum.sort_by(& &1.inserted_at, :desc)
                      |> List.first()

        if last_clock do
          render(conn, :show, clock: last_clock)
        else
          conn
          |> put_status(:not_found)
          |> json(%{error: "Aucun pointage trouvé pour cet utilisateur"})
        end
    end
  end


  def show(conn, %{"id" => id}) do
    clock = Clocking.get_clock!(id)
    render(conn, :show, clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Clocking.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Clocking.update_clock(clock, clock_params) do
      render(conn, :show, clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Clocking.get_clock!(id)

    with {:ok, %Clock{}} <- Clocking.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
