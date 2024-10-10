defmodule TimemanagerWeb.WorkingtimeController do
  use TimemanagerWeb, :controller

  alias Timemanager.Workingtimes
  alias Timemanager.Workingtimes.Workingtime

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Workingtimes.list_workingtimes()
    render(conn, :index, workingtimes: workingtimes)
  end

  def create(conn, %{"workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <- Workingtimes.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtimes/#{workingtime}")
      |> render(:show, workingtime: workingtime)
    end
  end

  def create_workingtime_by_user(conn, %{"userId" => user_id, "workingtime" => workingtime_params}) do
    workingtime_params = Map.put(workingtime_params, "user_id", user_id)

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

  def show(conn, %{"id" => id}) do
    case Workingtimes.get_workingtime(id) do
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
