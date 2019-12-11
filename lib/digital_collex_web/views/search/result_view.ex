defmodule DigitalCollexWeb.Search.ResultView do
  use DigitalCollexWeb, :view

  def lux_facet_options(label, buckets) do
    Enum.map(buckets, fn {name, count} -> %{label: "#{name}: #{count}", value: name} end)
    |> List.insert_at(0, %{label: "Filter by #{label}", value: ""})
    |> Jason.encode!()
  end
end
