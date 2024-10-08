defmodule Timemanager.Repo.Migrations.RenameTimesToTimeInClocks do
  use Ecto.Migration

  def change do
    rename table(:clocks), :times, to: :time
  end
end
