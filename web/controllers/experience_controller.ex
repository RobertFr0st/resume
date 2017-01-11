defmodule Resume.ExperienceController do
  use Resume.Web, :controller

  alias Resume.Experience

  plug :layout_view

  @doc false
  def layout_view(conn, _) do
    conn
    |> put_layout({Resume.LayoutView, "app.html"})
    |> put_view(Resume.ExperienceView)
  end

  def new(conn, _params) do
    changeset = Experience.changeset(%Experience{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"experience" => experience_params}) do
    changeset = Experience.changeset(%Experience{}, experience_params)

    case Repo.insert(changeset) do
      {:ok, _experience} ->
        conn
        |> put_flash(:info, "Experience created successfully.")
        |> redirect(to: registration_path(conn, :show))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    experience = Repo.get!(Experience, id)
    changeset = Experience.changeset(experience)
    render(conn, "edit.html", experience: experience, changeset: changeset)
  end

  def update(conn, %{"id" => id, "experience" => experience_params}) do
    experience = Repo.get!(Experience, id)
    changeset = Experience.changeset(experience, experience_params)

    case Repo.update(changeset) do
      {:ok, _experience} ->
        conn
        |> put_flash(:info, "Experience updated successfully.")
        |> redirect(to: registration_path(conn, :show))
      {:error, changeset} ->
        render(conn, "edit.html", experience: experience, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    experience = Repo.get!(Experience, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(experience)

    conn
    |> put_flash(:info, "Experience deleted successfully.")
    |> redirect(to: registration_path(conn, :show))
  end
end
