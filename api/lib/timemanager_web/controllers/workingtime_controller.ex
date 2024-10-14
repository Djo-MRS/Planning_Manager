defmodule TimemanagerWeb.WorkingtimeController do
  use TimemanagerWeb, :controller

  alias Timemanager.Workingtimes
  alias Timemanager.Workingtimes.Workingtime

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, %{"userID" => user_id}) do
    workingtimes = Workingtimes.list_workingtimes(user_id)
    render(conn, :index, workingtimes: workingtimes)
  end

  def create_workingtime_by_user(conn, %{"userID" => user_id, "workingtime" => workingtime_params}) do
    workingtime_params = Map.put(workingtime_params,"user_id", user_id)

    with {:ok, %Workingtime{} = workingtime} <- Workingtimes.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> render(:show, workingtime: workingtime)
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

  def show(conn, %{"userID" => user_id, "id" => id}) do
    case Workingtimes.get_workingtime_by_user(id, user_id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Workingtime not found"})
      workingtime ->
        render(conn, :show, workingtime: workingtime)
    end
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    case Workingtimes.get_workingtime(id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Workingtime not found"})

      workingtime ->
        case Workingtimes.update_workingtime(workingtime, workingtime_params) do
          {:ok, workingtime} ->
            render(conn, :show, workingtime: workingtime)

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
    case Workingtimes.get_workingtime(id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Workingtime not found"})

      workingtime ->
        case Workingtimes.delete_workingtime(workingtime) do
          {:ok, _workingtime} ->
            send_resp(conn, :no_content, "")

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
end
