defmodule HeatGraph.Repo.Migrations.CreateSensor do
  use Ecto.Migration

  def change do
    create table(:sensors) do
      add :user_id, :integer
      add :name, :string, null: false
      add :desc, :string

      timestamps
    end

  end
end
