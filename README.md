# DigitalCollex

An experiment in elixir. Collaboration born out of discussions at Samvera
Connect 2019.

# Get Started

You can run a local development and test environment with
[devstack](https://github.com/nulib/devstack). It is docker-based and has good documentation in its README.

We'll use postgres and elasticsearch. You can also run pgadmin and kibana for inspecting those services, respectively.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`. Or use `iex -S mix phx.server`
    for a repl and server in one!

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

# Run tests

Ensure devstack is running your test services with `devstack -t up -d db`

Run tests with `mix test`

Run tests and generate a coverage report with `mix test --cover`

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
