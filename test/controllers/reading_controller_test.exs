defmodule HeatGraph.ReadingControllerTest do
  use HeatGraph.ConnCase

  alias HeatGraph.Reading
  @valid_attrs %{timestamp: "2010-04-17 14:00:00", value: "120.5"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, reading_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing readings"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, reading_path(conn, :new)
    assert html_response(conn, 200) =~ "New reading"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, reading_path(conn, :create), reading: @valid_attrs
    assert redirected_to(conn) == reading_path(conn, :index)
    assert Repo.get_by(Reading, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, reading_path(conn, :create), reading: @invalid_attrs
    assert html_response(conn, 200) =~ "New reading"
  end

  test "shows chosen resource", %{conn: conn} do
    reading = Repo.insert! %Reading{}
    conn = get conn, reading_path(conn, :show, reading)
    assert html_response(conn, 200) =~ "Show reading"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, reading_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    reading = Repo.insert! %Reading{}
    conn = get conn, reading_path(conn, :edit, reading)
    assert html_response(conn, 200) =~ "Edit reading"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    reading = Repo.insert! %Reading{}
    conn = put conn, reading_path(conn, :update, reading), reading: @valid_attrs
    assert redirected_to(conn) == reading_path(conn, :show, reading)
    assert Repo.get_by(Reading, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    reading = Repo.insert! %Reading{}
    conn = put conn, reading_path(conn, :update, reading), reading: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit reading"
  end

  test "deletes chosen resource", %{conn: conn} do
    reading = Repo.insert! %Reading{}
    conn = delete conn, reading_path(conn, :delete, reading)
    assert redirected_to(conn) == reading_path(conn, :index)
    refute Repo.get(Reading, reading.id)
  end
end
