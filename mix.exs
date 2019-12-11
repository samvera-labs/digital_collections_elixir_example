defmodule DigitalCollex.MixProject do
  use Mix.Project

  @version "0.1.1"

  def project do
    [
      app: :digital_collex,
      version: @version,
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.circle": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      releases: releases()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {DigitalCollex.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:certifi, "~> 2.4"},
      {:credo, "~> 1.1.5"},
      {:ecto_sql, "~> 3.1"},
      {:elasticsearch, "~> 1.0.0"},
      {:excoveralls, "~> 0.12.1"},
      {:gettext, "~> 0.11"},
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.0"},
      {:phoenix, "~> 1.4.11"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_pubsub, "~> 1.1"},
      {:plug_cowboy, "~> 2.0"},
      {:postgrex, ">= 0.0.0"},
      {:pow, "~> 1.0.15"},
      {:pow_assent, "~> 0.4.4"},
      {:ssl_verify_fun, "~> 1.1"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end

  defp releases do
    [
      digital_collex: [
        include_executables_for: [:unix],
        applications: [
          digital_collex: :permanent,
          observer: :permanent,
          runtime_tools: :permanent
        ],
        steps: [&build_assets/1, :assemble, :tar]
      ]
    ]
  end

  def build_assets(release) do
    System.cmd("yarn", ["install"], cd: "assets")
    System.cmd("yarn", ["deploy"], cd: "assets")
    Mix.Tasks.Phx.Digest.run([])
    release
  end
end
