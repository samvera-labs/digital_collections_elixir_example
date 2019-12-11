defmodule DigitalCollex.Resource do
  defstruct [:id, :repository_document]

  defimpl Elasticsearch.Document do
    def id(resource), do: resource.id
    def routing(_), do: false

    def encode(resource) do
      resource.repository_document
      |> Map.delete("_version")
      |> Map.delete("")
    end
  end
end
