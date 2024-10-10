defmodule TimemanagerWeb.ClockController do
  use TimemanagerWeb, :controller

  alias Timemanager.Clocking
  alias Timemanager.Clocking.Clock

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    clocks = Clocking.list_clocks()
    render(conn, :index, clocks: clocks)
  end
  def create_for_user(conn, %{"userID" => user_id, "clock" => clock_params}) do
    clock_params = Map.put(clock_params, "user_id", user_id)

    with {:ok, %Clock{} = clock} <- Clocking.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clocks/#{clock.id}")
      |> render(:show, clock: clock)
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Invalid data"})
    end
  end

  def get_by_user(conn, %{"userID" => user_id}) do
    clocks = Clocking.get_clocks_by_user(user_id)
    render(conn, :index, clocks: clocks)
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
