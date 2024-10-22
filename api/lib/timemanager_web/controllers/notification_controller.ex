defmodule TimemanagerWeb.NotificationController do
  use TimemanagerWeb, :controller

  alias Timemanager.Notifications
  alias Timemanager.Notifications.Notification

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    notifications = Notifications.list_notifications()
    render(conn, :index, notifications: notifications)
  end

  def create(conn, %{"notification" => notification_params}) do
    with {:ok, %Notification{} = notification} <- Notifications.create_notification(notification_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/notifications/#{notification}")
      |> render(:show, notification: notification)
    end
  end

  def show(conn, %{"id" => id}) do
    notification = Notifications.get_notification!(id)
    render(conn, :show, notification: notification)
  end

  def update(conn, %{"id" => id, "notification" => notification_params}) do
    notification = Notifications.get_notification!(id)

    with {:ok, %Notification{} = notification} <- Notifications.update_notification(notification, notification_params) do
      render(conn, :show, notification: notification)
    end
  end

  def delete(conn, %{"id" => id}) do
    notification = Notifications.get_notification!(id)

    with {:ok, %Notification{}} <- Notifications.delete_notification(notification) do
      send_resp(conn, :no_content, "")
    end
  end
end
