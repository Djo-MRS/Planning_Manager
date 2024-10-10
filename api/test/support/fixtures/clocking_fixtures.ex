defmodule Timemanager.ClockingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.Clocking` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        times: ~D[2024-10-07],
        user: "some user"
      })
      |> Timemanager.Clocking.create_clock()

    clock
  end
end
