defmodule Resume.Repo.Migrations.CreateResumeEducations do
  use Ecto.Migration

  def change do
    create table(:resume_educations, primary_key: false) do
      add :resume_id, references(:resumes, on_delete: :delete_all)
      add :education_id, references(:educations, on_delete: :delete_all)
    end
  end
end
