defmodule TimemanagerWeb.Middleware.CheckXsrf do
  import Plug.Conn
  alias Timemanager.Auth.Token
  alias Joken.Signer
  require Logger

  @behaviour Plug

  def init(default), do: default

  def call(conn, _opts) do
    Logger.info("Middleware CheckXsrf triggered for path: #{conn.request_path}")

    # Skip XSRF check for sign_in and sign_up routes
    case {conn.method, conn.request_path} do
      {"POST", "/api/users/sign_in"} ->
        Logger.info("Skipping XSRF check for sign_in route")
        conn

      {"POST", "/api/users/sign_up"} ->
        Logger.info("Skipping XSRF check for sign_up route")
        conn

      _ ->
        # Retrieve the JWT from the HTTP-only cookie
        jwt = conn.req_cookies["jwt"]
        Logger.debug("JWT found in cookies: #{inspect(jwt)}")

        # Verify if the JWT is present
        case jwt do
          nil ->
            Logger.error("No JWT found in cookies")
            conn
            |> send_resp(401, "Unauthorized: No token provided")
            |> halt()

          _ ->
            # Verify the c-xsrf-token in the cookies
            xsrf_token = conn.cookies["c-xsrf-token"]
            Logger.debug("XSRF token from cookies: #{inspect(xsrf_token)}")

            # Create the Joken signer (using HS256 and the secret key)
            signer = Signer.create("HS256", System.get_env("JWT_SECRET") || "batman")

            # Decode the JWT to retrieve claims
            case Joken.verify(jwt, signer) do
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
