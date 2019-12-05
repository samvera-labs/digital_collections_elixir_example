IO.puts "start indexing ..."
defmodule Benchmark do
  def measure(function) do
    function
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end
defmodule IndexerTask do
  def index do
    :ok = Elasticsearch.Index.hot_swap(DigitalCollex.ElasticsearchCluster, "resources")
  end
end
result = Benchmark.measure(&IndexerTask.index/0)
IO.puts "done indexing ...#{result}"
