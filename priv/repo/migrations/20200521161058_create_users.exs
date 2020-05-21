defmodule Topflow.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    create table(:users) do
      add(:firstname, :string, null: false)
      add(:middlename, :string)
      add(:lastname, :string, null: false)
      add(:email, :string, null: false)
      add(:password_hash, :string, null: false)
      add(:user_role, :string, default: "user")

      add(:suspended, :boolean, default: false)
      add(:verified, :boolean, default: false)

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
