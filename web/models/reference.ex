defmodule Resume.Reference do
  use Resume.Web, :model

  schema "references" do
    field :name, :string
    field :association, :string
    field :phone, :string
    field :email, :string
    belongs_to :user, Resume.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :association, :phone, :email])
    |> cast_assoc(:user)
    |> validate_required([:name, :association])
    |> assoc_constraint(:user)
  end
end
