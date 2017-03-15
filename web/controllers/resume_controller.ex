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
    render(conn, "new.html", changeset: changeset,
                             user: user,
                             skill_ids: [],
                             exp_ids: [],
                             edu_ids: [],
                             award_ids: [],
                             ref_ids: [])
  end

  def create(conn, %{"resume" => resume_params}) do
    checked_skills_ids = checked_ids(conn, "checked_skills")
    checked_educations_ids = checked_ids(conn, "checked_educations")
    checked_experiences_ids = checked_ids(conn, "checked_experiences")
    checked_references_ids = checked_ids(conn, "checked_references")
    checked_awards_ids = checked_ids(conn, "checked_awards")

    changeset = 
      build_assoc(conn.assigns.current_user, :resumes)
      |> Resume.changeset(resume_params)

    case Repo.insert(changeset) do
      {:ok, resume} ->
        do_update_intermediate_table(Skill, :skills, resume.id, checked_skills_ids)
        do_update_intermediate_table(Education, :educations, resume.id, checked_educations_ids)
        do_update_intermediate_table(Experience, :experiences, resume.id, checked_experiences_ids)
        do_update_intermediate_table(Reference, :references, resume.id, checked_references_ids)
        do_update_intermediate_table(Award, :awards, resume.id, checked_awards_ids)

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
    |> Helper.preload_attributes

    render(conn, "show.html", resume: resume)
  end

  def edit(conn, %{"id" => id}) do
    resume = Repo.get!(Resume, id)
    changeset = Resume.changeset(resume)

    user = Coherence.current_user(conn) |> Helper.preload_attributes
    render(conn, "edit.html", resume: resume, changeset: changeset,
                             user: user,
                             skill_ids: [],
                             exp_ids: [],
                             edu_ids: [],
                             award_ids: [],
                             ref_ids: [])
  end

  def update(conn, %{"id" => id, "resume" => resume_params}) do
    resume = Repo.get!(Resume, id)
    changeset = Resume.changeset(resume, resume_params)

    checked_skills_ids = checked_ids(conn, "checked_skills")
    checked_educations_ids = checked_ids(conn, "checked_educations")
    checked_experiences_ids = checked_ids(conn, "checked_experiences")
    checked_references_ids = checked_ids(conn, "checked_references")
    checked_awards_ids = checked_ids(conn, "checked_awards")

    case Repo.update(changeset) do
      {:ok, resume} ->
        do_update_intermediate_table(Skill, :skills, resume.id, checked_skills_ids)
        do_update_intermediate_table(Education, :educations, resume.id, checked_educations_ids)
        do_update_intermediate_table(Experience, :experiences, resume.id, checked_experiences_ids)
        do_update_intermediate_table(Reference, :references, resume.id, checked_references_ids)
        do_update_intermediate_table(Award, :awards, resume.id, checked_awards_ids)

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

  defp do_update_intermediate_table(model, model_atom, resume_id, new_ids) do
    if length(new_ids) > 0 do
      new_attributes = new_ids |> Enum.map(fn(id) -> Repo.get(model, id) end) 

      Repo.get(Resume, resume_id)
      |> Repo.preload(model_atom)
      |> Ecto.Changeset.change
      |> Ecto.Changeset.put_assoc(model_atom, new_attributes)
      |> Repo.update
    end
  end
end
