defmodule Resume.SkillController do
  use Resume.Web, :controller

  alias Resume.Skill

  import Ecto, only: [build_assoc: 2]

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"skill" => skill_params}) do
    changeset = 
      build_assoc(conn.assigns.current_user, :skills)
      |> Skill.changeset(skill_params)

    case Repo.insert(changeset) do
      {:ok, _skill} ->
        conn
        |> put_flash(:info, "Skill created successfully.")
        |> redirect(to: registration_path(conn, :show))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Skill creation was unsuccessful")
        |> render(:new, changeset: changeset)
    end
  end

  def edit(conn, id) do
    render conn, "edit.html"
  end

  def update(conn, id) do
  end

  def delete(conn, id) do
  end
end
