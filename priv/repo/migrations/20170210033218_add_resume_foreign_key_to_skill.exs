defmodule Resume.Repo.Migrations.AddResumeForeignKeyToSkill do
  use Ecto.Migration

  def change do
    alter table(:skills) do
      add :resume_id, references(:resumes, on_delete: :delete_all)
    end
    create index(:skills, [:resume_id])
  end
end
