defmodule HeatGraph.SensorTest do
  use HeatGraph.ModelCase

  alias HeatGraph.Sensor

  @valid_attrs %{desc: "some content", name: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Sensor.changeset(%Sensor{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Sensor.changeset(%Sensor{}, @invalid_attrs)
    refute changeset.valid?
  end
end
