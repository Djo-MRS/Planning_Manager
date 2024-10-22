defmodule TimemanagerWeb.Plugs.RequireAuth do
  import Plug.Conn
  alias Timemanager.Auth.Token

  def init(default), do: default

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        case Token.verify_n_validate(token) do
          {:ok, _claims} -> conn
          {:error, _reason} -> unauthorized(conn)
        end
      _ -> unauthorized(conn)
    end
  end

  defp unauthorized(conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:unauthorized, Jason.encode!(%{error: "Unauthorized: No token provided or invalid token"}))
    |> halt()
  end
end
