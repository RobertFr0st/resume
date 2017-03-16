defmodule Resume.Repo.Migrations.CreateResumeReferences do
  use Ecto.Migration

  def change do
    create table(:resume_references, primary_key: false) do
      add :resume_id, references(:resumes, on_delete: :delete_all)
      add :reference_id, references(:references, on_delete: :delete_all)
    end
  end
end
