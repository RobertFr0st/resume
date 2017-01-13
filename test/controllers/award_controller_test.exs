defmodule Resume.AwardControllerTest do
  use Resume.ConnCase

  alias Resume.Award
  @valid_attrs %{on: %{day: 17, month: 4, year: 2010}, title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, award_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing awards"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, award_path(conn, :new)
    assert html_response(conn, 200) =~ "New award"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, award_path(conn, :create), award: @valid_attrs
    assert redirected_to(conn) == award_path(conn, :index)
    assert Repo.get_by(Award, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, award_path(conn, :create), award: @invalid_attrs
    assert html_response(conn, 200) =~ "New award"
  end

  test "shows chosen resource", %{conn: conn} do
    award = Repo.insert! %Award{}
    conn = get conn, award_path(conn, :show, award)
    assert html_response(conn, 200) =~ "Show award"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, award_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    award = Repo.insert! %Award{}
    conn = get conn, award_path(conn, :edit, award)
    assert html_response(conn, 200) =~ "Edit award"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    award = Repo.insert! %Award{}
    conn = put conn, award_path(conn, :update, award), award: @valid_attrs
    assert redirected_to(conn) == award_path(conn, :show, award)
    assert Repo.get_by(Award, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    award = Repo.insert! %Award{}
    conn = put conn, award_path(conn, :update, award), award: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit award"
  end

  test "deletes chosen resource", %{conn: conn} do
    award = Repo.insert! %Award{}
    conn = delete conn, award_path(conn, :delete, award)
    assert redirected_to(conn) == award_path(conn, :index)
    refute Repo.get(Award, award.id)
  end
end
