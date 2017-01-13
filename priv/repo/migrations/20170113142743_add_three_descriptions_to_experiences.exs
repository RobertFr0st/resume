defmodule Resume.Repo.Migrations.AddThreeDescriptionsToExperiences do
  use Ecto.Migration

  def change do
    alter table(:experiences) do
      add :description_one, :string
      add :description_two, :string
      add :description_three, :string
    end
  end
end
