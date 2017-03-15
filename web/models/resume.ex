defmodule Resume.Resume do
  use Resume.Web, :model

  alias Resume.Repo
  alias Resume.User
  alias Resume.Award
  alias Resume.Experience
  alias Resume.Education
  alias Resume.Reference
  alias Resume.Skill

  schema "resumes" do
    field :file_name, :string
    field :objective, :string

    belongs_to :user, User

    many_to_many :awards, Award, join_through: "resume_awards", on_replace: :delete
    many_to_many :experiences, Experience, join_through: "resume_experiences", on_replace: :delete
    many_to_many :educations, Education, join_through: "resume_educations", on_replace: :delete
    many_to_many :references, Reference, join_through: "resume_references", on_replace: :delete
    many_to_many :skills, Skill, join_through: "resume_skills", on_replace: :delete

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(resume, params \\ %{}) do
    resume
    |> Repo.preload(:skills)
    |> Repo.preload(:educations)
    |> Repo.preload(:experiences)
    |> Repo.preload(:references)
    |> Repo.preload(:awards)
    |> cast(params, [:file_name, :objective])
    |> put_assoc(:skills, Map.get(params, "skills"))
    |> put_assoc(:awards, Map.get(params, "awards"))
    |> put_assoc(:experiences, Map.get(params, "experiences"))
    |> put_assoc(:educations, Map.get(params, "educations"))
    |> put_assoc(:references, Map.get(params, "references"))
    |> cast_assoc(:user)
    |> validate_required([:file_name, :objective])
  end
end
