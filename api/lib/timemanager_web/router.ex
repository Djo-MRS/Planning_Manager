defmodule TimemanagerWeb.Router do
  #alias Hex.API.User
  use TimemanagerWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
    plug TimemanagerWeb.Middleware.CheckXsrf
  end

  scope "/api", TimemanagerWeb do
    pipe_through :api

    get "/clocks/:userID", ClockController, :get_by_user
    post "/clocks/:userID", ClockController, :create_for_user

    get "/users/:id", UserController, :show
    get "/users", UserController, :index
    post "/users", UserController, :create
    delete "/users/:id", UserController, :delete
    put "/users/:id", UserController, :update
    #get "/users", UserController, :show_with_query

    get "/workingtime/:userID", WorkingtimeController, :index
    get "/workingtime/:userID/:id", WorkingtimeController, :show
    post "/workingtime/:userID", WorkingtimeController, :create_workingtime_by_user
    put "/workingtime/:id", WorkingtimeController, :update
    delete "/workingtimettttt/:id", WorkingtimeController, :delete

    post "/users/sign_in", AuthController, :login
    post "/users/sign_up", AuthController, :sign_up
    delete "/users/sign_out", AuthController, :sign_out
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:timemanager, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TimemanagerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
