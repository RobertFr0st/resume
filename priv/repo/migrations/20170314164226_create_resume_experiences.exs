defmodule Resume.Repo.Migrations.CreateResumeExperiences do
  use Ecto.Migration

  def change do
    create table(:resume_experiences, primary_key: false) do
      add :resume_id, references(:resumes, on_delete: :delete_all)
      add :experience_id, references(:experiences, on_delete: :delete_all)
    end
  end
end
