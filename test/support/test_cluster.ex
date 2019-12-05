defmodule DigitalCollex.Elasticsearch.Test.Cluster do
  @moduledoc false

  use Elasticsearch.Cluster

  def init(_config) do
    {:ok,
     %{
       api: Elasticsearch.API.HTTP,
       json_library: Jason,
       url: "http://localhost:9202",
       indexes: %{
         resources: %{
           settings: "priv/elasticsearch/resources.json",
           store: DigitalCollex.Elasticsearch.Test.Store,
           sources: [DigitalCollex.Resource],
           bulk_page_size: 5000,
           bulk_wait_interval: 0
         }
       }
     }}
  end
end
