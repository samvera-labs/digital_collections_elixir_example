ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(DigitalCollex.Repo, :manual)

# This may become an issue if tests add to the index
# If you want to modify the index in a test you should use a different index
# name, could be set up via setup context.
IO.puts "Indexing fixtures"
Elasticsearch.Index.hot_swap(DigitalCollex.ElasticsearchCluster, "resources")
{:ok, _} = DigitalCollex.Elasticsearch.Test.Cluster.start_link()
{:ok, _} = Elasticsearch.wait_for_boot(DigitalCollex.Elasticsearch.Test.Cluster, 15)
# Ensure that wallaby is started for functional test suites
{:ok, _} = Application.ensure_all_started(:wallaby)
Application.put_env(:wallaby, :base_url, DigitalCollexWeb.Endpoint.url)

defmodule DigitalCollexWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias DigitalCollex.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import DigitalCollexWeb.Router.Helpers
    end
  end

  setup tags do

    :ok = Ecto.Adapters.SQL.Sandbox.checkout(DigitalCollex.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(DigitalCollex.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(DigitalCollex.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)

    {:ok, session: session}
  end
end
