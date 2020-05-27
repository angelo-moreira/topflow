defmodule Topflow.Repo.Migrations.AddItems do
  use Ecto.Migration

  def up do
    # Enables Ltree extension
    execute "CREATE EXTENSION IF NOT EXISTS ltree"

    create table(:items, primary_key: false) do
      # the primary key is UUID
      add :id, :uuid, primary_key: true
      add(:name, :string, null: false)
      add(:url, :string, null: false)
      add(:user, references(:users))
      add(:tags, :json)
      add(:path, :ltree)
      add(:privacy, :string, default: "private")

      timestamps()
    end

    # Add an index for fast lookups
    # GIST is an index type for Postgres, please refer to https://www.postgresql.org/docs/9.4/indexes-types.html for more information
    create index(:items, [:path], using: "GIST")
  end
end
