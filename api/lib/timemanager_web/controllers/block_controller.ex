defmodule TimemanagerWeb.BlockController do
  use TimemanagerWeb, :controller

  def block(conn, _params) do
    conn
    |> put_status(403)
    |> json(%{error: "Access denied"})
  end
end
