defmodule Resume.Repo.Migrations.AddResumeForeignKeyToEducation do
  use Ecto.Migration

  def change do
    alter table(:educations) do
      add :resume_id, references(:resumes)
    end
    create index(:educations, [:resume_id])
  end
end
