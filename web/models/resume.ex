defmodule Resume.Resume do
  use Resume.Web, :model

  alias Resume.Repo, as: Repo

  schema "resumes" do
    field :file_name, :string
    field :objective, :string

    belongs_to :user, Resume.User

    many_to_many :awards, Resume.Award, join_through: "resume_awards", on_replace: :delete
    many_to_many :experiences, Resume.Experience, join_through: "resume_experiences", on_replace: :delete
    many_to_many :educations, Resume.Education, join_through: "resume_educations", on_replace: :delete
    many_to_many :references, Resume.Reference, join_through: "resume_references", on_replace: :delete
    many_to_many :skills, Resume.Skill, join_through: "resume_skills", on_replace: :delete

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:file_name, :objective])
    |> cast_assoc(:user)
    |> validate_required([:file_name, :objective])
  end
end
