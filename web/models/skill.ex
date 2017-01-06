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
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :start_date, :end_date, :description, :category])
    |> validate_required([:name, :start_date, :end_date, :description, :category])
  end
end
