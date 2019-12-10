defmodule DigitalCollex.SearchTest do
  use ExUnit.Case, async: true

  test "gets a result from a query" do
    {:ok, result} = DigitalCollex.Search.query("39_ParrotsandToucans")
    assert result.total == 1
    assert [%DigitalCollex.Search.Hit{id: _, title: ["39_ParrotsandToucans"]}] = result.hits
    assert %{"state" => [{"pending", 1}]} = result.facets
  end

  test "it can facet" do
    {:ok, result} = DigitalCollex.Search.query("39_ParrotsandToucans", %{"state" => ["complete"]})
    assert result.total == 0
  end
end
