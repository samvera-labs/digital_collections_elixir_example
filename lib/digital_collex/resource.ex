defmodule DigitalCollex.Resource do
  defstruct [:id, :title, :state]

  defimpl Elasticsearch.Document do
    def id(resource), do: resource.id
    def routing(_), do: false

    def encode(resource) do
      %{
        title: resource.title,
        state: resource.state
      }
    end
  end
end
