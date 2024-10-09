defmodule TimemanagerWeb.UserController do
  use TimemanagerWeb, :controller

  alias Timemanager.Accounts
  alias Timemanager.Accounts.User
  import Ecto.Query
  alias Timemanager.Repo

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()

    with {:ok, users} <- Accounts.list_users() do
      render(conn, :index, users: users)
    else
      _error ->
        conn
        |> put_status(:not_found)
        |> render("error.json", message: "Users not found")
    end
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    else
      _error ->
        conn
        |> put_status(:not_found)
        |> render("error.json", message: "User not created")
    end
  end

  def show(conn, %{"id" => id}) do
    try do
        user = Accounts.get_user!(id)
        render(conn, :show, user: user)
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_status(:not_found)
        |> render("error.json", message: "User not found")
    end
  end

  def show_with_query(conn, %{"email" => email, "username" => username}) do
    try do
        query = from(u in User, where: u.email == ^email and u.username == ^username)
        user = Repo.one(query)
        render(conn, :show, user: user)
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_status(:not_found)
        |> render("error.json", message: "User not found")
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    else
      _error ->
        conn
        |> put_status(:not_found)
        |> render("error.json", message: "User not updated")
    end
  end

  @spec delete(any(), map()) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    else
      _error ->
        conn
        |> put_status(:not_found)
        |> render("error.json", message: "User not deleted")
    end
  end
end
