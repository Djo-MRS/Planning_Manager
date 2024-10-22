defmodule Timemanager.Notifications.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notifications" do
    field :title, :string
    field :message, :string
    field :date, :utc_datetime
    field :sender, :string
    field :receiver, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:title, :message, :date, :sender, :receiver])
    |> validate_required([:title, :message, :date, :sender, :receiver])
  end
end
