defmodule Timemanager.Repo.Migrations.ChangeTimesToUtcDatetimeInClocks do
  use Ecto.Migration

  def up do
    alter table(:clocks) do
      modify :time, :utc_datetime, from: :date
    end
  end

  def down do
    alter table(:clocks) do
      modify :time, :date, from: :utc_datetime
    end
  end
end
