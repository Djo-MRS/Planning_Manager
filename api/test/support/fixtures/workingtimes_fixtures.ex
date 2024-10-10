defmodule Timemanager.WorkingtimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.Workingtimes` context.
  """

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        end: ~D[2024-10-07],
        start: ~D[2024-10-07]
      })
      |> Timemanager.Workingtimes.create_workingtime()

    workingtime
  end
end
