# DigitalCollex

An experiment in elixir. Collaboration born out of discussions at Samvera
Connect 2019.

# Get Started

You can run a local development and test environment with
[devstack](https://github.com/nulib/devstack). It is docker-based and has good documentation in its README.

We'll use postgres and elasticsearch. You can also run pgadmin and kibana for inspecting those services, respectively.

We're using `Pow` for Ecto-backed user authentication, and `PowAssent` for Github authentication. The application requires two environment variables which you should put in a `.env` file in the project root and must contain:

```
# .env
export GITHUB_CLIENT_ID=[your-client-id]
export GITHUB_CLIENT_SECRET=[your-client-secret]
```

Please see the [PowAssent documentation](https://github.com/pow-auth/pow_assent#setting-up-a-provider) for more information on setting up the provider.

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `cd assets && yarn install`
- Run `source .env` to configure Github authentication.
- Start Phoenix endpoint with `mix phx.server`. Or use `iex -S mix phx.server`
  for a repl and server in one!

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

# Run tests

Ensure devstack is running your test services with `devstack -t up -d db`

Run tests with `mix test`

Run tests and generate a coverage report with `mix test --cover`

## Index

`mix elasticsearch.build resources --cluster DigitalCollex.ElasticsearchCluster`

## Learn more

- Official website: http://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Mailing list: http://groups.google.com/group/phoenix-talk
- Source: https://github.com/phoenixframework/phoenix

## Contributing

If you're working on a PR for this project, create a feature branch off of `main`.

This repository follows the [Samvera Community Code of Conduct](https://samvera.atlassian.net/wiki/spaces/samvera/pages/405212316/Code+of+Conduct) and [language recommendations](https://github.com/samvera/maintenance/blob/master/templates/CONTRIBUTING.md#language).  Please ***do not*** create a branch called `master` for this repository or as part of your pull request; the branch will either need to be removed or renamed before it can be considered for inclusion in the code base and history of this repository.
