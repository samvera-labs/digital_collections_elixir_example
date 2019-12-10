ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(DigitalCollex.Repo, :manual)

# This may become an issue if tests add to the index
# If you want to modify the index in a test you should use a different index
# name, could be set up via setup context.
IO.puts "Indexing fixtures"
Elasticsearch.Index.hot_swap(DigitalCollex.ElasticsearchCluster, "resources")
# Ensure that wallaby is started for functional test suites
{:ok, _} = Application.ensure_all_started(:wallaby)
Application.put_env(:wallaby, :base_url, DigitalCollexWeb.Endpoint.url)
