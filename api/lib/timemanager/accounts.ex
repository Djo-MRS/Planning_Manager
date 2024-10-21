defmodule Timemanager.Accounts do
  @moduledoc """
  The Accounts context.
  """
  import Plug.Conn

  import Ecto.Query, warn: false
  alias Timemanager.Repo

  alias Timemanager.Accounts.User
  import Bcrypt, only: [hash_pwd_salt: 1]
  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
def get_user(id), do: Repo.get(User, id)
  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end


  def authenticate_user(conn, email, password) do
    user = Repo.get_by(User, email: email)

    case user do
      nil -> {:error, :invalid_credentials}
      _ ->
        if Bcrypt.check_pass(user, password) do
          {token, c_xsrf_token} = Timemanager.Auth.Token.generate_jwt(user)

          # Stocker le c-xsrf-token dans un cookie HTTP-Only
          conn = put_resp_cookie(conn, "c-xsrf-token", c_xsrf_token, http_only: true)

          {:ok, token, conn} # Renvoie le token JWT et la connexion mise à jour
        else
          {:error, :invalid_credentials}
        end
    end
  end

end
