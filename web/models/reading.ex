defmodule HeatGraph.Reading do
  use HeatGraph.Web, :model
  import Ecto.Query
  alias Ecto.Adapters.SQL

  schema "readings" do
    field :timestamp, Calecto.DateTimeUTC
    field :value, :float
    belongs_to :sensor, HeatGraph.Sensor

    timestamps
  end

  @required_fields ~w(sensor_id timestamp value)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    {:ok, timestamp} = Calendar.DateTime.Parse.rfc2822_utc(params["timestamp"])
    params = Map.put(params, "timestamp", timestamp)

    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def graph_data(sensor_id) do
    rs = HeatGraph.Repo.all from r in HeatGraph.Reading,
      where: r.sensor_id == ^sensor_id

    Enum.map(rs, 
      &([Calendar.DateTime.Format.js_ms(&1.timestamp), c2f(&1.value)]))
  end

  def graph_settings(sensor_id) do
    xmin = HeatGraph.Repo.one! from r in HeatGraph.Reading, select: min(r.timestamp)
    xmax = HeatGraph.Repo.one! from r in HeatGraph.Reading, select: max(r.timestamp)
    ymin = HeatGraph.Repo.one! from r in HeatGraph.Reading, select: min(r.value)
    ymax = HeatGraph.Repo.one! from r in HeatGraph.Reading, select: max(r.value)

    %{
      "xmin": erl2js(xmin),
      "xmax": erl2js(xmax),
      "ymin": c2f(ymin),
      "ymax": c2f(ymax),
    }
  end

  defp erl2js(date) do
    date 
    |> Calendar.DateTime.from_erl!("UTC")
    |> Calendar.DateTime.Format.js_ms
  end

  defp c2f(degrees) do
    (degrees * 9) / 5 + 32
  end
end
