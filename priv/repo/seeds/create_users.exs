defmodule Topflow.Seeds.CreateUsers do
  @moduledoc """
  Seeds file to create multiple fake users for testing.
  THIS SHOULD NOT BE RUN IN PROD ONLY IN TEST FROM seeds
  """

  alias Topflow.Users.User
  alias Topflow.Repo

  def generate_users() do
    users = [
      %{
        "email" => "angelo.moreira+test-admin@gmail.com",
        "firstname" => "Angelo Admin",
        "lastname" => "Favery1",
        "middlename" => "Moreira Admin",
        "password" => "testing123",
        "password_confirmation" => "testing123",
        "role" => "admin",
        "verified" => true
      },
      %{
        "email" => "angelo.moreira+test-suspended@gmail.com",
        "firstname" => "Angelo Suspended",
        "lastname" => "Favery1",
        "middlename" => "Moreira Suspended",
        "password" => "testing123",
        "password_confirmation" => "testing123",
        "verified" => true,
        "suspended" => true
      },
      %{
        "email" => "angelo.moreira+test-unverified@gmail.com",
        "firstname" => "Angelo Unverified",
        "lastname" => "Favery1",
        "middlename" => "Moreira Unverified",
        "password" => "testing123",
        "password_confirmation" => "testing123"
      },
      %{
        "email" => "angelo.moreira+test1@gmail.com",
        "firstname" => "Angelo1",
        "lastname" => "Favery1",
        "middlename" => "Moreira1",
        "password" => "testing123",
        "password_confirmation" => "testing123",
        "verified" => true
      },
      %{
        "email" => "angelo.moreira+test2@gmail.com",
        "firstname" => "Angelo2",
        "lastname" => "Favery2",
        "middlename" => "Moreira2",
        "password" => "testing123",
        "password_confirmation" => "testing123",
        "verified" => true
      }
    ]

    Enum.map(users, &add_user/1)
  end

  defp add_user(user) do
    %User{}
    |> User.changeset(user)
    |> Repo.insert!()
  end
end
