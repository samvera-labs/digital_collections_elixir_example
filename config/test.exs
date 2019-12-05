use Mix.Config

# Configure your database
config :digital_collex, DigitalCollex.Repo,
  username: "docker",
  password: "d0ck3r",
  database: "digital_collex_test",
  hostname: "localhost",
  port: System.get_env("DB_PORT", "5434"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :digital_collex, DigitalCollexWeb.Endpoint,
  http: [port: System.get_env("HTTP_PORT", "4002")],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
