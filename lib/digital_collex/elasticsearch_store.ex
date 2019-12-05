defmodule DigitalCollex.ElasticsearchStore do
  alias DigitalCollex.Indexer
  @behaviour Elasticsearch.Store

  def get_many_documents(number) do
    (1..number)
    |> Stream.map(fn(x) ->
      %{
        "id" => "#{x}",
        "title_ssim" => ["Record ##{x}"]
      }
    end)
  end

  @impl true
  def stream(schema) do
    Indexer.convert_figgy_documents(get_many_documents(15_000_000))
  end

  @impl true
  def transaction(fun) do
    fun.()
  end
end
