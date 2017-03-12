defmodule Resume.Skill do
  use Resume.Web, :model

  schema "skills" do
    field :name, :string
    belongs_to :user, Resume.User
    belongs_to :resume, Resume.Resume

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.

  Supported catagories: work, volunteer, education, awards, publications, skills, languages
  """
  def changeset(skill, params \\ %{}) do

    cast(skill, params, [:name])
    |> cast_assoc(:user)
    |> validate_required([:name])
    |> validate_length(:name, min: 1, max: 16)
    |> assoc_constraint(:user)
  end
end
