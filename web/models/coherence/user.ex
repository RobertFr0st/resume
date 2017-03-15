defmodule Resume.User do
  use Resume.Web, :model
  use Coherence.Schema

  schema "users" do
    field :name, :string
    field :email, :string
    field :job_title, :string
    field :phone, :string
    field :address, :string
    coherence_schema

    has_many :awards, Resume.Award
    has_many :experiences, Resume.Experience
    has_many :educations, Resume.Education
    has_many :references, Resume.Reference
    has_many :resumes, Resume.Resume
    has_many :skills, Resume.Skill
    timestamps
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :email, :job_title, :phone, :address] ++ coherence_fields)
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end
end
