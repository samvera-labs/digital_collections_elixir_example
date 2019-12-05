defmodule DigitalCollex.Elasticsearch.Test.Store do
  defmodule MockedGetter do
    def get_url("https://figgy.princeton.edu/catalog.json?rows=100") do
      File.read!("test/fixtures/catalog.json")
    end
  end
  alias DigitalCollex.Indexer
  @behaviour Elasticsearch.Store

  @impl true
  def stream(schema) do
    Indexer.convert_figgy_documents(Indexer.get_figgy_catalog(MockedGetter))
  end

  @impl true
  def transaction(fun) do
    fun.()
  end
end
