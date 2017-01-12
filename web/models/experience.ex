defmodule Resume.Experience do
  use Resume.Web, :model

  schema "experiences" do
    field :category, :string
    field :organization, :string
    field :position, :string
    field :from, Ecto.Date
    field :to, Ecto.Date

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:category, :organization, :position, :from, :to])
    |> validate_required([:category, :organization, :position, :from, :to])
    |> validate_inclusion(:category, ["Work", "Volunteer", "Project"])
  end
end
