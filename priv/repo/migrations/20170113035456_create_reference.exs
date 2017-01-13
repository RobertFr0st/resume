defmodule Resume.Repo.Migrations.CreateReference do
  use Ecto.Migration

  def change do
    create table(:references) do
      add :name, :string
      add :association, :string
      add :phone, :string
      add :email, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
    create index(:references, [:user_id])

  end
end
