defmodule DigitalCollex.Search do
  def query(input) do
    Elasticsearch.post(DigitalCollex.ElasticsearchCluster,
      "/resources/_doc/_search",
      %{"query" =>
        %{"query_string" =>
          %{"query" => input}
        }
      }
    )
  end
end
