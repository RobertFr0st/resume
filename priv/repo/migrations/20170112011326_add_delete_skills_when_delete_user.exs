defmodule Resume.Repo.Migrations.AddDeleteSkillsWhenDeleteUser do
  use Ecto.Migration

  def change do
    change :user_id, references(:users, on_delete: :delete_all)
  end
end
