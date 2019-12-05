ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(DigitalCollex.Repo, :manual)
{:ok, _} = DigitalCollex.Elasticsearch.Test.Cluster.start_link()
{:ok, _} = Elasticsearch.wait_for_boot(DigitalCollex.Elasticsearch.Test.Cluster, 15)
