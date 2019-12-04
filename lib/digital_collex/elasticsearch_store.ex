defmodule DigitalCollex.ElasticsearchStore do
  @behaviour Elasticsearch.Store

  @impl true
  def stream(schema) do
    # []
  end

  @impl true
  def transaction(fun) do
    fun.()
  end
end
