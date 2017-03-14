defmodule Resume.Repo.Migrations.AddResumeForeignKeyToReference do
  use Ecto.Migration

  def change do
    alter table(:references) do
      add :resume_id, references(:resumes)
    end
    create index(:references, [:resume_id])
  end
end
