defmodule DigitalCollex.Search do
  defmodule Hit do
    defstruct [:id, :title]
  end

  defmodule Results do
    defstruct [:total, :hits]
  end

  def query(input) do
    response =
      Elasticsearch.post(
        DigitalCollex.ElasticsearchCluster,
        "/resources/_doc/_search",
        %{"query" => %{"query_string" => %{"query" => input}}}
      )

    case response do
      {:ok, result} -> {:ok, result |> map_response}
      {:error, _} -> response
    end
  end

  # %{"_shards" => %{"failed" => 0, "skipped" => 0, "successful" => 5, "total" => 5}, "hits" => %{"hits" => [%{"_id" => "2815703b-1d95-42a0-8393-de9f3bcd6667", "_index" => "resources-1575662942446087", "_score" => 3.3330417, "_source" => %{"title" => ["\"Will the Dogs Make Trouble?\""]}, "_type" => "_doc"}], "max_score" => 3.3330417, "total" => 1}, "timed_out" => false, "took" => 5}
  defp map_response(%{"hits" => %{"hits" => results, "total" => total}}) do
    # Enum.map(results, &build_result/1)
    hits = Enum.map(results, &build_result/1)
    %Results{total: total, hits: hits}
  end

  defp build_result(%{"_id" => id, "_source" => %{"title" => titles}}) do
    %Hit{id: id, title: Enum.map(titles, &remove_escaped_quotes/1)}
  end

  defp remove_escaped_quotes(str) do
    String.replace(str, "\"", "")
  end
end
