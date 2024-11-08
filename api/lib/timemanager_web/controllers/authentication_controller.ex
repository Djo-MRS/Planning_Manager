defmodule TimemanagerWeb.AuthController do
  use TimemanagerWeb, :controller
  alias Timemanager.Accounts
  alias Timemanager.Accounts.User
  alias Timemanager.Repo

  def login(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(conn, email, password) do
      {:ok, token, user, conn} ->
        user = Repo.preload(user, :role)
        conn
        |> put_resp_cookie("jwt", token, http_only: true)
        |> json(%{
          message: "Logged in successfully.",
          token: token,
          user: %{
            id: user.id,
            firstname: user.firstname,
            lastname: user.lastname,
            email: user.email,
            role: user.role.name
          }
        })

      {:error, :invalid_credentials} ->
        conn
        |> send_resp(401, "Unauthorized: Invalid credentials")

      error ->
        IO.inspect(error, label: "Unexpected error")
        conn
        |> send_resp(500, "Internal Server Error")
    end
  end


  def sign_up(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, %User{} = user} ->
        user = Repo.preload(user, :role)
        conn
        |> put_status(:created)
        |> json(%{
          message: "User created successfully",
          user_id: user.id,
          role: user.role.name
        })

      {:error, %Ecto.Changeset{} = changeset} ->
        errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)

        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: errors})
    end
  end

  def sign_out(conn, _params) do
    conn
    |> delete_resp_cookie("jwt")
    |> send_resp(:no_content, "")
  end
end
