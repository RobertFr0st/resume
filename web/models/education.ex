defmodule Resume.Education do
  use Resume.Web, :model

  schema "educations" do
    field :organization, :string
    field :to, Ecto.Date
    field :from, Ecto.Date
    field :status, :string
    field :degree, :string
    field :gpa, :float
    belongs_to :user, Resume.User
#    belongs_to :resume, Resume.Resume

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:organization, :to, :from, :status, :degree, :gpa])
    |> cast_assoc(:user)
    |> validate_required([:organization, :to, :from, :status, :degree, :gpa])
    |> assoc_constraint(:user)
  end
end
