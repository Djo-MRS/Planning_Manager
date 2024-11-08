defmodule TimemanagerWeb.Router do
  use TimemanagerWeb, :router

  pipeline :public_api do
    plug :accepts, ["json"]
  end

  # Pipeline pour les routes authentifiées (avec vérification XSRF)
  pipeline :authenticated_api do
    plug :accepts, ["json"]
    plug TimemanagerWeb.Middleware.CheckXsrf
    plug TimemanagerWeb.Plugs.RequireAuth
  end

  scope "/api", TimemanagerWeb do
    pipe_through :public_api

    post "/users/sign_in", AuthController, :login
    post "/users/sign_up", AuthController, :sign_up

    get "/favicon.ico", BlockController, :block
    get "/robots.txt", BlockController, :block


    pipe_through :authenticated_api

    delete "/users/sign_out", AuthController, :sign_out

    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    post "/users", UserController, :create
    delete "/users/:id", UserController, :delete
    put "/users/:id", UserController, :update
    get "/users", UserController, :show_with_query

    get "/workingtime/:userID", WorkingtimeController, :index
    get "/workingtime/:userID/:id", WorkingtimeController, :show
    post "/workingtime/:userID", WorkingtimeController, :create_workingtime_by_user
    put "/workingtime/:id", WorkingtimeController, :update
    delete "/workingtime/:id", WorkingtimeController, :delete

    get "/clocks/:userID", ClockController, :get_by_user
    post "/clocks/:userID", ClockController, :create_for_user

    resources "/teams", TeamController, only: [:index, :create, :show, :update, :delete] do
      get "/users", UserController, :list_team_users
      post "/add_user", TeamController, :add_user_to_team
      delete "/remove_user", TeamController, :remove_user_from_team
    end
  end

  if Application.compile_env(:timemanager, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TimemanagerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
