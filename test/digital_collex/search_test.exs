defmodule DigitalCollex.SearchTest do
  use ExUnit.Case, async: true

  test "gets a result from a query" do
    {:ok, result} = DigitalCollex.Search.query("dogs")
    assert get_in(result, ["hits", "total"]) == 1

    assert get_in(result, ["hits", "hits", Access.at(0), "_source"]) == %{
             "title" => ["\"Will the Dogs Make Trouble?\""]
           }
  end
end
