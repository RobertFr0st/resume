defmodule Resume.Award do
  use Resume.Web, :model

  schema "awards" do
    field :title, :string
    field :on, Ecto.Date
    belongs_to :user, Resume.User

    many_to_many :resumes, Resume.Resume, join_through: "resume_awards"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :on])
    |> cast_assoc(:user)
    |> validate_required([:title, :on])
    |> assoc_constraint(:user)
  end
end
