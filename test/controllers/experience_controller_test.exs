defmodule Resume.ExperienceControllerTest do
  use Resume.ConnCase

  alias Resume.Experience

import Plug.Conn
  @valid_attrs %{category: "some content", from: %{day: 17, month: 4, year: 2010}, organization: "some content", position: "some content", to: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  #setup tests via setting up user object on test db as a seed and log in here in setup

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, experience_path(conn, :new)
    assert html_response(conn, 200) =~ "New experience"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, experience_path(conn, :create), experience: @valid_attrs
    assert redirected_to(conn) == registration_path(conn, :show)
    assert Repo.get_by(Experience, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, experience_path(conn, :create), experience: @invalid_attrs
    assert html_response(conn, 200) =~ "New experience"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    experience = Repo.insert! %Experience{}
    conn = get conn, experience_path(conn, :edit, experience)
    assert html_response(conn, 200) =~ "Edit experience"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    experience = Repo.insert! %Experience{}
    conn = put conn, experience_path(conn, :update, experience), experience: @valid_attrs
    assert redirected_to(conn) == registration_path(conn, :show)
    assert Repo.get_by(Experience, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    experience = Repo.insert! %Experience{}
    conn = put conn, experience_path(conn, :update, experience), experience: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit experience"
  end

  test "deletes chosen resource", %{conn: conn} do
    experience = Repo.insert! %Experience{}
    conn = delete conn, experience_path(conn, :delete, experience)
    assert redirected_to(conn) == registration_path(conn, :show)
    refute Repo.get(Experience, experience.id)
  end
end
