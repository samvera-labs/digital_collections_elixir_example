defmodule DigitalCollex.Search do
  defmodule Hit do
    defstruct [:id, :title]
  end

  defmodule Results do
    defstruct [:total, :hits, :facets]
  end

  def query(input, facets \\ %{}) do
    facets = build_elasticsearch_facets(facets)

    response =
      Elasticsearch.post(
        DigitalCollex.ElasticsearchCluster,
        "/resources/_doc/_search",
        %{
          "query" => %{
            "bool" => %{
              "must" => %{
                "query_string" => %{"query" => input}
              },
              "filter" => facets
            }
          },
          "aggs" => %{
            "state" => %{
              "terms" => %{"field" => "state.keyword"}
            },
            "collections" => %{
              "terms" => %{"field" => "member_of_collection_titles.keyword"}
            }
          }
        }
      )

    case response do
      {:ok, result} -> {:ok, result |> map_response}
      {:error, _} -> response
    end
  end

  # Example facets:
  # %{"collections" => ["Bibliotheca Cicognara"]}
  def build_elasticsearch_facets(facets) do
    facets
    |> Enum.filter(fn({term, value}) -> value != [""] end)
    |> Enum.map(&build_facet/1)
  end

  # value is a list like ["Bibliotheca Cicognara"]
  def build_facet({term, value}) do
    value
    |> Enum.map(&map_facet_term(term, &1))
  end

  defp map_facet_term("collections", value) do
    map_facet_term("member_of_collection_titles", value)
  end

  defp map_facet_term(term, value) do
      %{ "term" => %{ "#{term}.keyword" => value } }
  end

  defp map_response(%{"hits" => %{"hits" => results, "total" => total}, "aggregations" => aggs}) do
    hits = Enum.map(results, &build_hits/1)
    facets = Enum.reduce(aggs, %{}, &parse_facets/2)
    %Results{total: total, hits: hits, facets: facets}
  end

  defp build_hits(%{"_id" => id, "_source" => %{"title" => titles}}) do
    %Hit{id: id, title: Enum.map(titles, &remove_escaped_quotes/1)}
  end

  defp parse_facets({key, %{"buckets" => buckets}}, acc) do
    acc
    |> Map.put(key, Enum.map(buckets, &parse_facet_hit/1))
  end

  defp parse_facet_hit(%{"key" => key, "doc_count" => count}) do
    {key, count}
  end

  defp remove_escaped_quotes(str) do
    String.replace(str, "\"", "")
  end
end
