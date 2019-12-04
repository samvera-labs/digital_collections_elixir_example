defmodule DigitalCollex.IndexerTest do
  alias DigitalCollex.Indexer
  use ExUnit.Case, async: true

  test "retrieves the JSON from the Figgy endpoint" do
    assert %{"response" => response} = Indexer.get_figgy_catalog
    # Extract the first document from the list keyed to "docs"
    assert %{"docs" => [doc | _]} = response
    assert %{"state_tesim" => _} = doc
  end
end
