defmodule TimemanagerWeb.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller, only: [json: 2]
  alias Joken.Signer
  require Logger

  @jwt_secret System.get_env("JWT_SECRET") || "batman"

  def init(default), do: default

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        signer = Joken.Signer.create("HS256", @jwt_secret)

        case Joken.verify(token, signer) do
          {:ok, claims} ->
            Logger.debug("JWT claims: #{inspect(claims)}")
            assign(conn, :claims, claims)

          {:error, reason} ->
            Logger.error("JWT validation failed: #{inspect(reason)}")
            conn
            |> put_status(:unauthorized)
            |> json(%{error: "Invalid token"})
            |> halt()
        end

      _ ->
        Logger.error("Authorization header not found or malformed")
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "No token provided"})
        |> halt()
    end
  end
end
