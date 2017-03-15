defmodule Resume.Repo.Migrations.CreateResumeAwards do
  use Ecto.Migration

  def change do
    create table(:resume_awards, primary_key: false) do
      add :resume_id, references(:resumes, on_delete: :delete_all)
      add :award_id, references(:awards, on_delete: :delete_all)
    end
  end
end
