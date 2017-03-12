defmodule Resume.Repo.Migrations.CreateResume do
  use Ecto.Migration

  def change do
    create table(:resumes) do
      add :file_name, :string
      add :objective, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
    create index(:resumes, [:user_id])

  end
end
