IO.puts "start indexing ..."
defmodule Benchmark do
  def measure(function) do
    function
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end
result = Benchmark.measure(fn -> Elasticsearch.Index.hot_swap(DigitalCollex.ElasticsearchCluster, "resources") end)
IO.puts "done indexing ...#{result}"
