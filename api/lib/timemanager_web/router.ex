defmodule TimemanagerWeb.Router do
  use TimemanagerWeb, :router

  # Pipeline pour les routes publiques (sans vérification XSRF)
  pipeline :public_api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
    # Aucune vérification de token ici pour les routes publiques
  end

  # Pipeline pour les routes authentifiées (avec vérification XSRF)
  pipeline :authenticated_api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
    plug TimemanagerWeb.Middleware.CheckXsrf  # Vérification XSRF pour les routes authentifiées
    plug TimemanagerWeb.Plugs.RequireAuth     # Vérification du token pour les routes authentifiées
  end

  scope "/api", TimemanagerWeb do
    # Routes publiques (sans vérification XSRF ni token)
    pipe_through :public_api

    post "/users/sign_in", AuthController, :login
    post "/users/sign_up", AuthController, :sign_up

    # Routes protégées (après connexion)
    pipe_through :authenticated_api

    delete "/users/sign_out", AuthController, :sign_out

    get "/users/:id", UserController, :show
    get "/users", UserController, :index
    post "/users", UserController, :create
    delete "/users/:id", UserController, :delete
    put "/users/:id", UserController, :update
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:timemanager, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TimemanagerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
