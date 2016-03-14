defmodule HeatGraph.SensorControllerTest do
  use HeatGraph.ConnCase

  alias HeatGraph.Sensor
  @valid_attrs %{desc: "some content", name: "some content", user_id: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sensor_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing sensors"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, sensor_path(conn, :new)
    assert html_response(conn, 200) =~ "New sensor"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, sensor_path(conn, :create), sensor: @valid_attrs
    assert redirected_to(conn) == sensor_path(conn, :index)
    assert Repo.get_by(Sensor, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sensor_path(conn, :create), sensor: @invalid_attrs
    assert html_response(conn, 200) =~ "New sensor"
  end

  test "shows chosen resource", %{conn: conn} do
    sensor = Repo.insert! %Sensor{}
    conn = get conn, sensor_path(conn, :show, sensor)
    assert html_response(conn, 200) =~ "Show sensor"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, sensor_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    sensor = Repo.insert! %Sensor{}
    conn = get conn, sensor_path(conn, :edit, sensor)
    assert html_response(conn, 200) =~ "Edit sensor"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    sensor = Repo.insert! %Sensor{}
    conn = put conn, sensor_path(conn, :update, sensor), sensor: @valid_attrs
    assert redirected_to(conn) == sensor_path(conn, :show, sensor)
    assert Repo.get_by(Sensor, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sensor = Repo.insert! %Sensor{}
    conn = put conn, sensor_path(conn, :update, sensor), sensor: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit sensor"
  end

  test "deletes chosen resource", %{conn: conn} do
    sensor = Repo.insert! %Sensor{}
    conn = delete conn, sensor_path(conn, :delete, sensor)
    assert redirected_to(conn) == sensor_path(conn, :index)
    refute Repo.get(Sensor, sensor.id)
  end
end
