defmodule Resume.SkillController do
  use Resume.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, _) do
  end

  def edit(conn, id) do
    render conn, "edit.html"
  end

  def update(conn, id) do
  end

  def delete(conn, id) do
  end
end
