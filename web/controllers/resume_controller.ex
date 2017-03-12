defmodule Resume.ResumeController do
  use Resume.Web, :controller

  import Resume.Controllers.Helpers

  alias Resume.Resume

  def index(conn, _params) do
    resumes = Repo.all(Resume)
    render(conn, "index.html", resumes: resumes)
  end

  def new(conn, _params) do
    changeset = Resume.changeset(%Resume{})

    user = Coherence.current_user(conn) |> preload_attributes
    render(conn, "new.html", changeset: changeset, user: user)
  end

  def create(conn, %{"resume" => resume_params}) do
    changeset = 
      build_assoc(conn.assigns.current_user, :resumes)
      |> Resume.changeset(resume_params)

    case Repo.insert(changeset) do
      {:ok, _resume} ->
        conn
        |> put_flash(:info, "Resume created successfully.")
        |> redirect(to: resume_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Resume creation failed")
        |> render(:new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    resume = Repo.get!(Resume, id)
    render(conn, "show.html", resume: resume)
  end

  def edit(conn, %{"id" => id}) do
    resume = Repo.get!(Resume, id)
    changeset = Resume.changeset(resume)
    render(conn, "edit.html", resume: resume, changeset: changeset)
  end

  def update(conn, %{"id" => id, "resume" => resume_params}) do
    resume = Repo.get!(Resume, id)
    changeset = Resume.changeset(resume, resume_params)

    case Repo.update(changeset) do
      {:ok, resume} ->
        conn
        |> put_flash(:info, "Resume updated successfully.")
        |> redirect(to: resume_path(conn, :show, resume))
      {:error, changeset} ->
        render(conn, "edit.html", resume: resume, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    resume = Repo.get!(Resume, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(resume)

    conn
    |> put_flash(:info, "Resume deleted successfully.")
    |> redirect(to: resume_path(conn, :index))
  end
end
