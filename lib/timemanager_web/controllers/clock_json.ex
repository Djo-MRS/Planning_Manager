defmodule TimemanagerWeb.ClockJSON do
  alias Timemanager.Clocking.Clock

  @doc """
  Renders a list of clocks.
  """
  def index(%{clocks: clocks}) do
    %{data: for(clock <- clocks, do: data(clock))}
  end

  @doc """
  Renders a single clock.
  """
  def show(%{clock: clock}) do
    %{data: data(clock)}
  end

  defp data(%Clock{} = clock) do
    %{
      id: clock.id,
      times: clock.time,
      status: clock.status,
      user: clock.user
    }
  end
end
