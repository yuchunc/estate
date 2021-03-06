# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :estate,
  ecto_repos: [Estate.Repo]

config :estate, Estate.Repo, migration_timestamps: [type: :utc_datetime_usec]

# Configures the endpoint
config :estate, EstateWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "t/aP57ZUxWAZNWrDDBIP+SH2zlwjwe0KoLpUdcR+pu1T6rM2QvT/jDSyPqYvUoo9",
  render_errors: [view: EstateWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Estate.PubSub,
  live_view: [signing_salt: "0Q86h0qf"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
