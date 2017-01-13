defmodule Resume.Repo.Migrations.CreateEducation do
  use Ecto.Migration

  def change do
    create table(:educations) do
      add :organization, :string
      add :to, :date
      add :from, :date
      add :status, :string
      add :degree, :string
      add :gpa, :float
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
    create index(:educations, [:user_id])

  end
end
