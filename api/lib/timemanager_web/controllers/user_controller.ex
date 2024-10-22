defmodule TimemanagerWeb.UserController do
  use TimemanagerWeb, :controller

  alias Timemanager.Accounts
  alias Timemanager.Accounts.User
  import Ecto.Query
  alias Timemanager.Repo
  alias Timemanager.Auth.Token



  action_fallback TimemanagerWeb.FallbackController


  def index(conn, _params) do
    case users = Accounts.list_users() |> Repo.preload(:role) do
      [] -> {:error, :not_found}
      _user -> render(conn, :index, users: users)
    end
  end


  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc -> String.replace(acc, "%{#{key}}", to_string(value)) end)
        end)
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: errors})
    end
  end

  def show(conn, %{"id" => id}) do
    case Accounts.get_user(id) |> Repo.preload(:role) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})
      user ->
        render(conn, :show, user: user)
    end
  end

  def show_with_query(conn, %{"email" => email, "firstname" => firstname, "lastname" => lastname}) do
    try do
        query = from(u in User, where: u.email == ^email and u.firstname == ^firstname and u.lastname == ^lastname)
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
    case Accounts.get_user(id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})

      user ->
        with {:ok, %User{} = updated_user} <- Accounts.update_user(user, user_params) do
          render(conn, :show, user: updated_user)
        else
          {:error, %Ecto.Changeset{} = changeset} ->
            errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
              Enum.reduce(opts, msg, fn {key, value}, acc -> String.replace(acc, "%{#{key}}", to_string(value)) end)
            end)
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{errors: errors})
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    case Accounts.get_user(id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})

      user ->
        with {:ok, %User{}} <- Accounts.delete_user(user) do
          send_resp(conn, :no_content, "")
        else
          _error ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{error: "Unable to delete user"})
        end
    end
  end
end
