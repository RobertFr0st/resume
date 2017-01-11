defmodule Resume.Repo.Migrations.CreateExperience do
  use Ecto.Migration

  def change do
    create table(:experiences) do
      add :category, :string
      add :organization, :string
      add :position, :string
      add :from, :date
      add :to, :date

      timestamps()
    end

  end
end
