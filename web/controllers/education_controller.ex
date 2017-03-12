defmodule Resume.EducationController do
  use Resume.Web, :controller

  alias Resume.Education

  def new(conn, _params) do
    changeset = Education.changeset(%Education{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"education" => education_params}) do
    changeset = 
      build_assoc(conn.assigns.current_user, :educations)
      |> Education.changeset(education_params)

    case Repo.insert(changeset) do
      {:ok, _education} ->
        conn
        |> put_flash(:info, "Education created successfully.")
        |> redirect(to: registration_path(conn, :show))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    education = Repo.get!(Education, id)
    changeset = Education.changeset(education)
    render(conn, "edit.html", education: education, changeset: changeset)
  end

  def update(conn, %{"id" => id, "education" => education_params}) do
    education = Repo.get!(Education, id)
    changeset = Education.changeset(education, education_params)

    case Repo.update(changeset) do
      {:ok, _education} ->
        conn
        |> put_flash(:info, "Education updated successfully.")
        |> redirect(to: registration_path(conn, :show))
      {:error, changeset} ->
        render(conn, "edit.html", education: education, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    education = Repo.get!(Education, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(education)

    conn
    |> put_flash(:info, "Education deleted successfully.")
    |> redirect(to: registration_path(conn, :show))
  end
end
