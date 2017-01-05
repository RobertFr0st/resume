defmodule Resume.Repo.Migrations.CreateSkill do
  use Ecto.Migration

  def change do
    create table(:skills) do
      add :name, :string
      add :start_date, :datetime
      add :end_date, :datetime
      add :description, :text
      add :category, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:skills, [:user_id])

  end
end
