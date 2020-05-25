defmodule Topflow.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    field :firstname, :string
    field :middlename, :string
    field :lastname, :string
    field :role, :string
    field :suspended, :boolean
    field :verified, :boolean

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [
      :firstname,
      :middlename,
      :lastname,
      :role,
      :suspended,
      :verified
    ])
    |> Ecto.Changeset.validate_required([:firstname, :lastname])
  end
end
