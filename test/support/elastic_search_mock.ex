defmodule DigitalCollex.ElasticsearchMock do
  @behaviour Elasticsearch.API

  @impl true
  def request(_config, :post, "/resources/_doc/_search", _data, _opts) do
    {:ok,
     %HTTPoison.Response{
       status_code: 200,
       body: %{
        "_shards" => %{
          "failed" => 0,
          "skipped" => 0,
          "successful" => 5,
          "total" => 5
        },
        "hits" => %{
          "hits" => [
            %{
              "_id" => "2815703b-1d95-42a0-8393-de9f3bcd6667",
              "_index" => "resources-1575577377983601",
              "_score" => 2.7338634,
              "_source" => %{"title" => ["\"Will the Dogs Make Trouble?\""]},
              "_type" => "_doc"
            }
          ],
          "max_score" => 2.7338634,
          "total" => 1
        },
        "timed_out" => false,
        "took" => 11
      }
     }}
  end
end
