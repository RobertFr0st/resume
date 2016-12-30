defmodule Resume.Repo.Migrations.CreateCoherenceUser do
  use Ecto.Migration
  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      # authenticatable
      add :password_hash, :string
      # recoverable
      add :reset_password_token, :string
      add :reset_password_sent_at, :datetime
      # lockable
      add :failed_attempts, :integer, default: 0
      add :locked_at, :datetime
      # unlockable_with_token
      add :unlock_token, :string
      
      timestamps()
    end
    create unique_index(:users, [:email])

  end
end
