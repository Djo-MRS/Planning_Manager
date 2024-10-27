defmodule Timemanager.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Plug.Conn
  import Ecto.Query, warn: false
  alias Timemanager.Repo

  alias Timemanager.Accounts.{User, Role}
  import Argon2, only: [hash_pwd_salt: 1, check_pass: 2]

  @doc """
  Returns the list of users.
  """
 def list_users do
  Repo.all(User) |> Repo.preload(:role)
end


  @doc """
  Gets a single user.
  """
  def get_user(id), do: Repo.get(User, id) |> Repo.preload(:role)


  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, updated_user} -> {:ok, Repo.preload(updated_user, :role)}
      error -> error
    end
  end


  @doc """
  Deletes a user.
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc """
  Crée un rôle.
  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Liste tous les rôles.
  """
  def list_roles do
    Repo.all(Role)
  end


 def authenticate_user(conn, email, password) do
  user = Repo.get_by(User, email: email) |> Repo.preload(:role)

  case user do
    nil -> {:error, :invalid_credentials}
    _ ->
      if Argon2.check_pass(user, password) do
        {token, c_xsrf_token} = Timemanager.Auth.Token.generate_jwt(user)

        conn = put_resp_cookie(conn, "c-xsrf-token", c_xsrf_token, http_only: false)

        {:ok, token, user, conn}
      else
        {:error, :invalid_credentials}
      end
  end
end
end
