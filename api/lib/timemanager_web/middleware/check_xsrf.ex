defmodule TimemanagerWeb.Middleware.CheckXsrf do
  import Joken
  import Plug.Conn

  alias Timemanager.Auth.Token # Assurez-vous d'importer le module de gestion des tokens

  @behaviour Plug

  def init(default), do: default

  def call(conn, _opts) do
    # Récupérer le JWT depuis le cookie HTTP Only
    jwt = conn |> req_cookie("jwt") # Assurez-vous que votre token JWT est stocké dans un cookie

    # Vérifier si le JWT est présent
    case jwt do
      nil ->
        conn
        |> send_resp(401, "Unauthorized: No token provided")
        |> halt()

      _ ->
        # Vérifier le c-xsrf-token dans les cookies
        xsrf_token = req_cookie(conn, "c-xsrf-token") # Utilisez get_req_cookie pour récupérer le cookie

        # Décodez le JWT pour récupérer les claims
        case Token.verify_n_validate(jwt) do
          {:ok, claims} ->
            # Vérifiez si le c-xsrf-token correspond à celui du JWT
            if claims["c-xsrf-token"] == xsrf_token do
              conn # Si tout va bien, passez la requête au prochain plug ou contrôleur
            else
              conn
              |> send_resp(403, "Forbidden: Invalid XSRF token")
              |> halt()
            end

          {:error, _reason} ->
            conn
            |> send_resp(401, "Unauthorized: Invalid token")
            |> halt()
        end
    end
  end
end
