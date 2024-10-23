defmodule TimemanagerWeb.Middleware.CheckXsrf do
  import Plug.Conn
  alias Timemanager.Auth.Token
  require Logger

  @behaviour Plug

  def init(default), do: default

  def call(conn, _opts) do
    Logger.info("Middleware CheckXsrf triggered for path: #{conn.request_path}")

    case {conn.method, conn.request_path} do
      {"POST", "/api/users/sign_in"} ->
        Logger.info("Skipping XSRF check for sign_in route")
        conn

      {"POST", "/api/users/sign_up"} ->
        Logger.info("Skipping XSRF check for sign_up route")
        conn

      _ ->
        jwt = get_req_header(conn, "Authorization") |> List.first()
        Logger.debug("JWT found in Authorization header: #{inspect(jwt)}")

        case jwt do
          nil ->
            Logger.error("No JWT found in Authorization header")
            conn
            |> send_resp(401, "Unauthorized: No token provided")
            |> halt()

          _ ->
            xsrf_token = get_req_header(conn, "X-CSRF-Token") |> List.first()
            Logger.debug("XSRF token from headers: #{inspect(xsrf_token)}")

            case Token.verify_n_validate(jwt) do
              {:ok, claims} ->
                Logger.debug("JWT claims: #{inspect(claims)}")

                if claims["c-xsrf-token"] == xsrf_token do
                  Logger.info("XSRF token is valid, proceeding with request")
                  conn # Proceed to the next plug or controller
                else
                  Logger.error("Invalid XSRF token")
                  conn
                  |> send_resp(403, "Forbidden: Invalid XSRF token")
                  |> halt()
                end

              {:error, reason} ->
                Logger.error("JWT validation failed: #{inspect(reason)}")
                conn
                |> send_resp(401, "Unauthorized: Invalid token")
                |> halt()
            end
        end
    end
  end
end
