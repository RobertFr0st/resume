defmodule Resume.Repo.Migrations.AddContactToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :job_title, :string
      add :phone, :string
      add :address, :string
    end
  end
end
