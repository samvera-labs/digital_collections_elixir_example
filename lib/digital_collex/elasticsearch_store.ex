defmodule DigitalCollex.ElasticsearchStore do
  alias DigitalCollex.Indexer
  @behaviour Elasticsearch.Store

  @impl true
  def stream(schema) do
    Indexer.convert_figgy_documents(Indexer.get_figgy_catalog())
  end

  @impl true
  def transaction(fun) do
    fun.()
  end
end
