defmodule Resume.Controllers.Helpers do
  import Plug.Conn
  import Phoenix.Controller
  import Ecto.Query

  alias Resume.Repo
  alias Resume.Skill
  alias Resume.Experience
  alias Resume.Education
  alias Resume.Award
  alias Resume.Reference
  alias Resume.Resume


  @doc """
  Preloads all the models the user owns
  """
  def preload_resume(users) do
    users
    |> Repo.preload(resumes: from(r in Resume, order_by: r.objective))
    |> preload_attributes
  end

  def preload_attributes(users) do
    users
    |> Repo.preload(skills: from(s in Skill, order_by: s.name))
    |> Repo.preload(experiences: from(exp in Experience, order_by: [desc: exp.to]))
    |> Repo.preload(educations: from(edu in Education, order_by: [desc: edu.to]))
    |> Repo.preload(awards: from(a in Award, order_by: [desc: a.on]))
    |> Repo.preload(references: from(r in Reference, order_by: r.name))
  end
end
