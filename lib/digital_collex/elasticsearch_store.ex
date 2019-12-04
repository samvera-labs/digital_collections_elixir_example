defmodule DigitalCollex.ElasticsearchStore do
  @behaviour Elasticsearch.Store

  @impl true
  def stream(schema) do
    [%DigitalCollex.Resource{id: "1", title: "a test title"}]
  end

  @impl true
  def transaction(fun) do
    fun.()
  end
end
