# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :topflow,
  ecto_repos: [Topflow.Repo]

# Configures the endpoint
config :topflow, TopflowWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5AWb6CVKI8qsQd+nECYJ7BClfR5oP3gVr7Dfe1zLJPs4smHVseagmpnSo6iVjGFj",
  render_errors: [view: TopflowWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Topflow.PubSub,
  live_view: [signing_salt: "wvdEyBUX"]

config :topflow, :pow,
  user: Topflow.Users.User,
  repo: Topflow.Repo,
  web_module: TopflowWeb

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
