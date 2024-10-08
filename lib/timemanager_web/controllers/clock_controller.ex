defmodule TimemanagerWeb.ClockController do
  use TimemanagerWeb, :controller

  alias Timemanager.Clocking
  alias Timemanager.Clocking.Clock

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    clocks = Clocking.list_clocks()
    render(conn, :index, clocks: clocks)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Clocking.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Clocking.update_clock(clock, clock_params) do
      render(conn, :show, clock: clock)
    end
  end
end
