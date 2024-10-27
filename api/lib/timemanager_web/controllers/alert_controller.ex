defmodule MyAppWeb.AlertController do
  use MyAppWeb, :controller

  @alerts Agent.start_link(fn -> nil end)

  def create(conn, %{"message" => message}) do
    Agent.update(@alerts, fn _ -> message end)
    json(conn, %{status: "ok"})
  end

  def index(conn, _params) do
    message = Agent.get(@alerts, & &1)
    json(conn, %{message: message})
  end
end
