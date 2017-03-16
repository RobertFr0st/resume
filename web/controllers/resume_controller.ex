defmodule Resume.ResumeController do
  use Resume.Web, :controller

  alias Resume.Controllers.Helpers, as: Helper
  alias Resume.Skill
  alias Resume.Experience
  alias Resume.Education
  alias Resume.Reference
  alias Resume.Award

  alias Resume.Resume
  alias Ecto.Changeset, as: Changeset

  def index(conn, _params) do
    resumes = Repo.all(Resume)
    render(conn, "index.html", resumes: resumes)
  end

  def new(conn, _params) do
    changeset = Resume.changeset(%Resume{})

    user = Coherence.current_user(conn) |> Helper.preload_attributes
    resume = %Resume{} |> Helper.preload_attributes
    render(conn, "new.html", resume: resume, changeset: changeset, user: user)
  end

  def create(conn, %{"resume" => resume_params}) do

    params = params_with_children(resume_params, conn)

    changeset = 
      build_assoc(conn.assigns.current_user, :resumes)
      |> Resume.changeset(params)

    case Repo.insert(changeset) do
      {:ok, resume} ->
        conn
        |> put_flash(:info, "Resume created successfully.")
        |> redirect(to: resume_path(conn, :index))
      {:error, changeset} ->
        user = Coherence.current_user(conn) |> Helper.preload_attributes
        resume = %Resume{} |> Helper.preload_attributes

        conn
        |> put_flash(:error, "Resume creation failed")
        |> render(:new, resume: resume, changeset: changeset, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    resume = Repo.get!(Resume, id)
    |> Helper.preload_attributes

    render(conn, "show.html", resume: resume)
  end

  def edit(conn, %{"id" => id}) do
    resume = Repo.get!(Resume, id)
    changeset = Resume.changeset(resume)

    user = Coherence.current_user(conn) |> Helper.preload_attributes
    render(conn, "edit.html", resume: resume |> Helper.preload_attributes, changeset: changeset, user: user)
  end



  def update(conn, %{"id" => id, "resume" => resume_params}) do
    resume = Repo.get!(Resume, id)

    params = params_with_children(resume_params, conn)

    changeset = Resume.changeset(resume, params)
    case Repo.update(changeset) do
      {:ok, resume} ->
        conn
        |> put_flash(:info, "Resume updated successfully.")
        |> redirect(to: resume_path(conn, :show, resume))
      {:error, changeset} ->
        user = Coherence.current_user(conn) |> Helper.preload_attributes

        conn
        |> render(:edit, resume: resume |> Helper.preload_attributes, changeset: changeset, user: user)
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

  defp params_with_children(resume_params, conn) do
    Map.put(resume_params, "skills", fetch_attributes(conn, "checked_skills", Skill))
    |> Map.put("educations", fetch_attributes(conn, "checked_educations", Education))
    |> Map.put("experiences", fetch_attributes(conn, "checked_experiences", Experience))
    |> Map.put("references", fetch_attributes(conn, "checked_references", Reference))
    |> Map.put("awards", fetch_attributes(conn, "checked_awards", Award))
  end

  defp fetch_attributes(conn, conn_key, model) do
    checked_ids(conn, conn_key) |> Enum.map(fn(id) -> Repo.get(model, id) end)
  end

  defp checked_ids(conn, checked_list) do
    conn.params[checked_list]
    |> filter_true_checkbox
  end
  
  defp filter_true_checkbox(checkbox_list) do
    unless checkbox_list == nil do
      checkbox_list
      |> Enum.map(&(do_get_id_if_true(&1)))
      |> Enum.filter(&(&1 != nil))
    else
      []
    end
  end

  defp do_get_id_if_true(tuple) do
    case tuple do
      {id, "true"} -> String.to_integer id
      _ -> nil
    end
  end
end
