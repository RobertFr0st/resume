defmodule Resume.Repo.Migrations.CreateResumeSkills do
  use Ecto.Migration

  def change do
    create table(:resume_skills, primary_key: false) do
      add :resume_id, references(:resumes, on_delete: :delete_all)
      add :skill_id, references(:skills, on_delete: :delete_all)
    end
  end
end
