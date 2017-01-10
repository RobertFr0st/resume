defmodule Resume.Repo.Migrations.RemoveDateDescriptionAndCatagoryFromSkills do
  use Ecto.Migration

  def change do
    alter table(:skills) do
      remove :start_date
      remove :end_date
      remove :category
      remove :description
    end
  end
end
