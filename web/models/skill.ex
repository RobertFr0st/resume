defmodule Resume.Skill do
  use Resume.Web, :model

  schema "skills" do
    field :name, :string
    field :start_date, Ecto.DateTime
    field :end_date, Ecto.DateTime
    field :description, :string
    field :category, :string
    belongs_to :user, Resume.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.

  Supported catagories: work, volunteer, education, awards, publications, skills, languages
  """
  def changeset(skill, params \\ %{}) do
    skill
    |> cast(params, [:name, :start_date, :end_date, :description, :category])
    |> cast_assoc(:user)
    |> validate_required([:name, :start_date, :end_date, :description, :category])
    |> assoc_constraint(:user)
  end
end
