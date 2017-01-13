defmodule Resume.Repo.Migrations.CreateAward do
  use Ecto.Migration

  def change do
    create table(:awards) do
      add :title, :string
      add :on, :date
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
    create index(:awards, [:user_id])

  end
end
