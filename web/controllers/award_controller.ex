defmodule Resume.AwardController do
  use Resume.Web, :controller

  alias Resume.Award
  def new(conn, _params) do
    changeset = Award.changeset(%Award{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"award" => award_params}) do
    changeset = 
      build_assoc(conn.assigns.current_user, :awards)
      |> Award.changeset(award_params)

    case Repo.insert(changeset) do
      {:ok, _award} ->
        conn
        |> put_flash(:info, "Award created successfully.")
        |> redirect(to: registration_path(conn, :show))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
  def edit(conn, %{"id" => id}) do
    award = Repo.get!(Award, id)
    changeset = Award.changeset(award)
    render(conn, "edit.html", award: award, changeset: changeset)
  end

  def update(conn, %{"id" => id, "award" => award_params}) do
    award = Repo.get!(Award, id)
    changeset = Award.changeset(award, award_params)

    case Repo.update(changeset) do
      {:ok, _award} ->
        conn
        |> put_flash(:info, "Award updated successfully.")
        |> redirect(to: registration_path(conn, :show))
      {:error, changeset} ->
        render(conn, "edit.html", award: award, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    award = Repo.get!(Award, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(award)

    conn
    |> put_flash(:info, "Award deleted successfully.")
    |> redirect(to: registration_path(conn, :show))
  end
end
