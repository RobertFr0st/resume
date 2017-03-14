defmodule Resume.Repo.Migrations.AddResumeForeignKeyToAward do
  use Ecto.Migration

  def change do
    alter table(:awards) do
      add :resume_id, references(:resumes)
    end
    create index(:awards, [:resume_id])
  end
end
