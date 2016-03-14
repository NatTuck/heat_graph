defmodule HeatGraph.SensorController do
  use HeatGraph.Web, :controller

  alias HeatGraph.Sensor

  plug :scrub_params, "sensor" when action in [:create, :update]

  def index(conn, _params) do
    sensors = Repo.all(Sensor)
    render(conn, "index.html", sensors: sensors)
  end

  def new(conn, _params) do
    changeset = Sensor.changeset(%Sensor{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sensor" => sensor_params}) do
    changeset = Sensor.changeset(%Sensor{}, sensor_params)

    case Repo.insert(changeset) do
      {:ok, _sensor} ->
        conn
        |> put_flash(:info, "Sensor created successfully.")
        |> redirect(to: sensor_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sensor = Repo.get!(Sensor, id)
    settings = HeatGraph.Reading.graph_settings(id)
    data     = HeatGraph.Reading.graph_data(id)
    render(conn, "show.html", sensor: sensor, settings: settings, data: data)
  end

  def edit(conn, %{"id" => id}) do
    sensor = Repo.get!(Sensor, id)
    changeset = Sensor.changeset(sensor)
    render(conn, "edit.html", sensor: sensor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sensor" => sensor_params}) do
    sensor = Repo.get!(Sensor, id)
    changeset = Sensor.changeset(sensor, sensor_params)

    case Repo.update(changeset) do
      {:ok, sensor} ->
        conn
        |> put_flash(:info, "Sensor updated successfully.")
        |> redirect(to: sensor_path(conn, :show, sensor))
      {:error, changeset} ->
        render(conn, "edit.html", sensor: sensor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sensor = Repo.get!(Sensor, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(sensor)

    conn
    |> put_flash(:info, "Sensor deleted successfully.")
    |> redirect(to: sensor_path(conn, :index))
  end
end
