defmodule Resume.Experience do
  use Resume.Web, :model

  schema "experiences" do
    field :category, :string
    field :organization, :string
    field :position, :string
    field :description_one, :string
    field :description_two, :string
    field :description_three, :string
    field :from, Ecto.Date
    field :to, Ecto.Date
    belongs_to :user, Resume.User

    many_to_many :resumes, Resume.Resume, join_through: "resume_experiences"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.

  #write date tests
  #write position and category string constraints + tests
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:category, :organization, :position, :from, :to, :description_one, :description_two, :description_three])
    |> cast_assoc(:user)
    |> validate_required([:category, :organization, :position, :from, :to])
    |> validate_inclusion(:category, ["Work", "Volunteer", "Project"])
    |> validate_first_date_before_second_date(:from, :to)
    |> validate_current_or_past_date(:to)
    |> validate_current_or_past_date(:from)
    |> assoc_constraint(:user)
  end

  def validate_current_or_past_date(%{changes: changes}=changeset, field) do
    if date = changes[field] do
      do_validate_current_or_past_date(changeset, field, date)
    else
      changeset
    end
  end

  defp do_validate_current_or_past_date(changeset, field, date) do
    today = Ecto.Date.utc
    if Ecto.Date.compare(today, date) == :lt do
      changeset
      |> add_error(field, "Date in the future")
    else
      changeset
    end
  end 

  def validate_first_date_before_second_date(%{changes: changes}=changeset, from, to) do
    cond do
      changes[from] == nil -> 
        changeset
        |> add_error(from, "From date is nil")
      changes[to] == nil ->
        changeset
        |> add_error(to, "To date is nil")
      Ecto.Date.compare(changes[from], changes[to]) == :gt ->
        changeset
        |> add_error(from, "From is after To")
      true ->
        changeset
    end
  end
end
