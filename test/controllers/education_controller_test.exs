defmodule Resume.EducationControllerTest do
  use Resume.ConnCase

  alias Resume.Education
  @valid_attrs %{degree: "some content", from: %{day: 17, month: 4, year: 2010}, gpa: "120.5", organization: "some content", status: "some content", to: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, education_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing educations"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, education_path(conn, :new)
    assert html_response(conn, 200) =~ "New education"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, education_path(conn, :create), education: @valid_attrs
    assert redirected_to(conn) == education_path(conn, :index)
    assert Repo.get_by(Education, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, education_path(conn, :create), education: @invalid_attrs
    assert html_response(conn, 200) =~ "New education"
  end

  test "shows chosen resource", %{conn: conn} do
    education = Repo.insert! %Education{}
    conn = get conn, education_path(conn, :show, education)
    assert html_response(conn, 200) =~ "Show education"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, education_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    education = Repo.insert! %Education{}
    conn = get conn, education_path(conn, :edit, education)
    assert html_response(conn, 200) =~ "Edit education"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    education = Repo.insert! %Education{}
    conn = put conn, education_path(conn, :update, education), education: @valid_attrs
    assert redirected_to(conn) == education_path(conn, :show, education)
    assert Repo.get_by(Education, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    education = Repo.insert! %Education{}
    conn = put conn, education_path(conn, :update, education), education: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit education"
  end

  test "deletes chosen resource", %{conn: conn} do
    education = Repo.insert! %Education{}
    conn = delete conn, education_path(conn, :delete, education)
    assert redirected_to(conn) == education_path(conn, :index)
    refute Repo.get(Education, education.id)
  end
end
