defmodule Resume.ReferenceControllerTest do
  use Resume.ConnCase

  alias Resume.Reference
  @valid_attrs %{association: "some content", email: "some content", name: "some content", phone: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, reference_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing references"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, reference_path(conn, :new)
    assert html_response(conn, 200) =~ "New reference"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, reference_path(conn, :create), reference: @valid_attrs
    assert redirected_to(conn) == reference_path(conn, :index)
    assert Repo.get_by(Reference, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, reference_path(conn, :create), reference: @invalid_attrs
    assert html_response(conn, 200) =~ "New reference"
  end

  test "shows chosen resource", %{conn: conn} do
    reference = Repo.insert! %Reference{}
    conn = get conn, reference_path(conn, :show, reference)
    assert html_response(conn, 200) =~ "Show reference"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, reference_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    reference = Repo.insert! %Reference{}
    conn = get conn, reference_path(conn, :edit, reference)
    assert html_response(conn, 200) =~ "Edit reference"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    reference = Repo.insert! %Reference{}
    conn = put conn, reference_path(conn, :update, reference), reference: @valid_attrs
    assert redirected_to(conn) == reference_path(conn, :show, reference)
    assert Repo.get_by(Reference, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    reference = Repo.insert! %Reference{}
    conn = put conn, reference_path(conn, :update, reference), reference: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit reference"
  end

  test "deletes chosen resource", %{conn: conn} do
    reference = Repo.insert! %Reference{}
    conn = delete conn, reference_path(conn, :delete, reference)
    assert redirected_to(conn) == reference_path(conn, :index)
    refute Repo.get(Reference, reference.id)
  end
end
