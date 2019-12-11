# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :digital_collex, DigitalCollex.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :digital_collex, DigitalCollexWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base,
  server: true

config :digital_collex, :pow_assent,
  providers: [
    github: [
      client_id: System.get_env("GITHUB_CLIENT_ID"),
      client_secret: System.get_env("GITHUB_CLIENT_SECRET"),
      strategy: Assent.Strategy.Github
    ]
  ]

config :digital_collex, DigitalCollex.ElasticsearchCluster,
  url:
    System.get_env("ELASTICSEARCH_ENDPOINT") ||
      raise("""
      environment variable ELASTICSEARCH_ENDPOINT is missing.
      This value is required in order to proceed.
      """),
  indexes: %{
    resources: %{
      settings: Path.join([:code.priv_dir(:digital_collex) |> to_string(), "elasticsearch/resources.json"]),
      store: DigitalCollex.ElasticsearchStore,
      sources: [DigitalCollex.Resource],
      bulk_page_size: 5000,
      bulk_wait_interval: 15_000
    }
  }
