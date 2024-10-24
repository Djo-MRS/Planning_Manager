defmodule TimemanagerWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :timemanager

  @session_options [
    store: :cookie,
    key: "_timemanager_key",
    signing_salt: "5z7ilx5p",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  plug Plug.Static,
    at: "/",
    from: :timemanager,
    gzip: false,
    only: TimemanagerWeb.static_paths()

  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :timemanager
  end

  # CORS configuration with specific origin
  plug CORSPlug,
    origin: ["http://localhost:8080"],  # Spécifie l'origine de ton frontend
    credentials: true,                  # Permet l'envoi des credentials (cookies, etc.)
    max_age: 8600,                      # Cache les règles CORS pendant 8600 secondes
    methods: ["GET", "POST", "PUT", "DELETE"]

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug TimemanagerWeb.Router
end
