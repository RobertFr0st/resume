defmodule Resume.Repo.Migrations.AddUserReferenceToExperience do
  use Ecto.Migration

  def change do
    add :user_id, references(:users, on_delete: :delete_all)
    create index(:experience, [:user_id])
  end
end
