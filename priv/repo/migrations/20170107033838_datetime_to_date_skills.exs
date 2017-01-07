defmodule Resume.Repo.Migrations.DatetimeToDateSkills do
  use Ecto.Migration

  def change do
    alter table(:skills) do
      modify :start_date, :date
      modify :end_date, :date
    end
  end
end
