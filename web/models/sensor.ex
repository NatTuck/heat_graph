defmodule HeatGraph.Sensor do
  use HeatGraph.Web, :model
  import Ecto.Query

  schema "sensors" do
    field :user_id, :integer
    field :name, :string
    field :desc, :string

    timestamps
  end

  @required_fields ~w(user_id name desc)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def sensors do
    HeatGraph.Sensor
    |> order_by(:id)
    |> HeatGraph.Repo.all
    |> Enum.map(fn (s) -> {s.id, s.name} end)
  end
end
