defmodule Resume.Experience do
  use Resume.Web, :model

  schema "experiences" do
    field :category, :string
    field :organization, :string
    field :position, :string
    field :from, Ecto.Date
    field :to, Ecto.Date
    belongs_to :user, Resume.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:category, :organization, :position, :from, :to])
    |> cast_assoc(:user)
    |> validate_required([:category, :organization, :position, :from, :to])
    |> validate_inclusion(:category, ["Work", "Volunteer", "Project"])
    |> assoc_constraint(:user)
  end
end
