defmodule HeatGraph.Repo.Migrations.CreateReading do
  use Ecto.Migration

  def change do
    create table(:readings) do
      add :timestamp, :datetime, null: false
      add :value, :float, null: false
      add :sensor_id, references(:sensors, on_delete: :delete_all), null: false

      timestamps
    end

    create index(:readings, [:sensor_id])
  end
end
