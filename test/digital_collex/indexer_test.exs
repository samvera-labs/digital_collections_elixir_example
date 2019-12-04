defmodule MockedGetter do
  def get_url("https://figgy.princeton.edu/catalog.json") do
    File.read!("test/fixtures/catalog.json")
  end
end

defmodule DigitalCollex.IndexerTest do
  alias DigitalCollex.Indexer
  use ExUnit.Case, async: true

  test "retrieves the JSON from the Figgy endpoint" do
    assert %{"response" => response} = Indexer.get_figgy_catalog(MockedGetter)
    # Extract the first document from the list keyed to "docs"
    assert %{"docs" => [doc | _]} = response
    assert %{"id" => "4c4bd924-70c5-4e1c-8bc5-2ad06a995ccc"} = doc
  end

  test "converts catalog data to elasticsearch documents" do
    %{"response" => %{"docs" => documents}} = Indexer.get_figgy_catalog(MockedGetter)
    output = Indexer.convert_figgy_documents(documents)
  end
end
