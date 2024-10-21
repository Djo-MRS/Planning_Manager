defmodule TimemanagerWeb.AuthController do
  use TimemanagerWeb, :controller
  alias Timemanager.Accounts
  alias Timemanager.Accounts.User


  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(conn, email, password) do
      {:ok, user} ->
        {token, xsrf_token} = Timemanager.Token.generate_jwt(user)
        conn
        |> put_resp_cookie("jwt", token, http_only: true) # met le token dans cookie http
        |> json(%{xsrf_token: xsrf_token, user_id: user.id, role: user.role}) # renvoie le xsrf dans le header

      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid credentials."})
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(conn, email, password) do
      {:ok, token, conn} ->
        conn
        |> put_resp_cookie("authorization", "Bearer #{token}")
        |> send_resp(200, "Logged in successfully.")

      {:error, :invalid_credentials} ->
        conn
        |> send_resp(401, "Unauthorized: Invalid credentials")
    end
  end

  def sign_up(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, %User{} = user} ->
        conn
        |> put_status(:created)
        |> json(%{message: "User created successfully", user_id: user.id})

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
  # DELETE /users/sign_out
  def sign_out(conn, _params) do
    conn
    |> delete_resp_cookie("jwt")
    |> send_resp(:no_content, "")
  end
end
