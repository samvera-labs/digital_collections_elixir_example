defmodule DigitalCollex.SearchTest do
  use ExUnit.Case, async: true

  test "gets a result from a query" do
    {:ok, result} = DigitalCollex.Search.query("39_ParrotsandToucans")
    assert result.total == 1
    assert [%DigitalCollex.Search.Hit{id: _, title: ["39_ParrotsandToucans"]}] = result.hits
  end
# %{"hits" => %{"hits" => [%{"_id" => "2815703b-1d95-42a0-8393-de9f3bcd6667", "_index" => "resources-1575662942446087", "_score" => 3.3330417, "_source" => %{"title" => ["\"Will the Dogs Make Trouble?\""]}, "_type" => "_doc"}], "max_score" => 3.3330417, "total" => 1}, "timed_out" => false, "took" => 5}
end
