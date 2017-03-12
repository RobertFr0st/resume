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
    |> Repo.preload(experiences: from(e in Experience, order_by: [desc: e.to]))
    |> Repo.preload(educations: from(e in Education, order_by: [desc: e.to]))
    |> Repo.preload(awards: from(e in Award, order_by: [desc: e.on]))
    |> Repo.preload(references: from(r in Reference, order_by: r.name))
  end
end
