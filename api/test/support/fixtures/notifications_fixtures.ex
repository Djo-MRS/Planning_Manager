defmodule Timemanager.NotificationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.Notifications` context.
  """

  @doc """
  Generate a notification.
  """
  def notification_fixture(attrs \\ %{}) do
    {:ok, notification} =
      attrs
      |> Enum.into(%{
        end: ~D[2024-10-21],
        start: ~D[2024-10-21],
        user: "some user"
      })
      |> Timemanager.Notifications.create_notification()

    notification
  end
end
