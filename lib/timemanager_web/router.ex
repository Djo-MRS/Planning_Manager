defmodule TimemanagerWeb.Router do
  use TimemanagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TimemanagerWeb do
    pipe_through :api

    # Routes for clocks
    get "/clocks/:userID", ClockController, :get_by_user
    post "/clocks/:userID", ClockController, :create_for_user

    # Routes for users
    get "/users/:id", UserController, :show
    post "/users", UserController, :create
    delete "/users/:id", UserController, :delete
    put "/users/:id", UserController, :update
    get "/users", UserController, :show_with_query

    # Routes for workingtimes
    get "/workingtime/:id", WorkingtimeController, :show
    post "/workingtime/:userId", WorkingtimeController, :create_workingtime_by_user
    put "/workingtime/:id", WorkingtimeController, :update
    delete "/workingtime/:id", WorkingtimeController, :delete
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
