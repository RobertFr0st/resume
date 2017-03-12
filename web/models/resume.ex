defmodule Resume.Resume do
  use Resume.Web, :model

  schema "resumes" do
    field :file_name, :string
    field :objective, :string

    belongs_to :user, Resume.User

    has_many :users_skills, through: [:user, :skills]
#   the association in the current module and one step through, got: [:user]

#    has_many :experiences, through: [:user]
#    has_many :educations, through: [:user]
#    has_many :awards, through: [:user]
#    has_many :references, through: [:user]
#    has_many :resume, through: [:user]
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:file_name, :objective])
    |> validate_required([:file_name, :objective])
  end
end
