defmodule Resume.Repo.Migrations.AddUserReferenceToExperience do
  use Ecto.Migration

  def change do

    alter table(:experiences) do
      add :user_id, references(:users, on_delete: :delete_all)
    end

    create index(:experiences, [:user_id])
  end
end
