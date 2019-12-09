defmodule DigitalCollex.Resource do
  defstruct [:id, :title, :state, :repository_document]

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
