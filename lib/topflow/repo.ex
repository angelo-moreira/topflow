defmodule Topflow.Repo do
  use Ecto.Repo,
    otp_app: :topflow,
    adapter: Ecto.Adapters.Postgres
end
