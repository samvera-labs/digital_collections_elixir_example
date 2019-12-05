defmodule DigitalCollex.Resource do
  defstruct [:id, :title]

  defimpl Elasticsearch.Document do
    def id(resource), do: resource.id
    def routing(_), do: false

    def encode(resource) do
      %{
        title: resource.title
      }
    end
  end
end
