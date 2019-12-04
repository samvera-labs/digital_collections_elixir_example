# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :digital_collex,
  ecto_repos: [DigitalCollex.Repo]

# Configures the endpoint
config :digital_collex, DigitalCollexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XNqnFVe7TjaSSoRcoaPXp5J3kiwGSppxBzS0Og2G5ITDQty1myfnL5kRbTdfqatF",
  render_errors: [view: DigitalCollexWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DigitalCollex.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
