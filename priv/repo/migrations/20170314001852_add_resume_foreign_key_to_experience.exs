defmodule Resume.Repo.Migrations.AddResumeForeignKeyToExperience do
  use Ecto.Migration

  def change do
    alter table(:experiences) do
      add :resume_id, references(:resumes)
    end
    create index(:experiences, [:resume_id])
  end
end
