defmodule TimemanagerWeb.NotificationControllerTest do
  use TimemanagerWeb.ConnCase

  import Timemanager.NotificationsFixtures

  alias Timemanager.Notifications.Notification

  @create_attrs %{
    start: ~D[2024-10-21],
    user: "some user",
    end: ~D[2024-10-21]
  }
  @update_attrs %{
    start: ~D[2024-10-22],
    user: "some updated user",
    end: ~D[2024-10-22]
  }
  @invalid_attrs %{start: nil, user: nil, end: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all notifications", %{conn: conn} do
      conn = get(conn, ~p"/api/notifications")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create notification" do
    test "renders notification when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/notifications", notification: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/notifications/#{id}")

      assert %{
               "id" => ^id,
               "end" => "2024-10-21",
               "start" => "2024-10-21",
               "user" => "some user"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/notifications", notification: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update notification" do
    setup [:create_notification]

    test "renders notification when data is valid", %{conn: conn, notification: %Notification{id: id} = notification} do
      conn = put(conn, ~p"/api/notifications/#{notification}", notification: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/notifications/#{id}")

      assert %{
               "id" => ^id,
               "end" => "2024-10-22",
               "start" => "2024-10-22",
               "user" => "some updated user"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, notification: notification} do
      conn = put(conn, ~p"/api/notifications/#{notification}", notification: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete notification" do
    setup [:create_notification]

    test "deletes chosen notification", %{conn: conn, notification: notification} do
      conn = delete(conn, ~p"/api/notifications/#{notification}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/notifications/#{notification}")
      end
    end
  end

  defp create_notification(_) do
    notification = notification_fixture()
    %{notification: notification}
  end
end
