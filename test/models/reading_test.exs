defmodule HeatGraph.ReadingTest do
  use HeatGraph.ModelCase

  alias HeatGraph.Reading

  @valid_attrs %{timestamp: "2010-04-17 14:00:00", value: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Reading.changeset(%Reading{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Reading.changeset(%Reading{}, @invalid_attrs)
    refute changeset.valid?
  end
end
