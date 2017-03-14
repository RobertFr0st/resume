defmodule Resume.Repo.Migrations.AddResumeForeignKeyToSkill do
  use Ecto.Migration

  def change do
    alter table(:skills) do
      add :resume_id, references(:resumes)
    end
    create index(:skills, [:resume_id])
  end
end
