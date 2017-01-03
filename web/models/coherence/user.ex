defmodule Resume.User do
  use Resume.Web, :model
  use Coherence.Schema

  schema "users" do
    field :name, :string
    field :email, :string
    coherence_schema

    timestamps
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :email] ++ coherence_fields)
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Resume.Repo.get(Resume.User, id)
  end

  def logged_in?(conn), do: !!current_user(conn)
end
