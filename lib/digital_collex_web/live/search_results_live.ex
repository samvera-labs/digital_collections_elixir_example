defmodule DigitalCollexWeb.SearchResultsLive do
  use Phoenix.LiveView
  alias DigitalCollexWeb.Router.Helpers, as: Routes

  def render(assigns) do
    Phoenix.View.render(DigitalCollexWeb.Search.ResultView, "live_results.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"f" => facets, "q" => query}, _uri, socket) do
    facets = remove_empty_strings(facets)
    {:ok, results} = DigitalCollex.Search.query(query, facets)
    socket = socket
             |> assign(:q, query)
             |> assign(:results, results)
             |> assign(:selected_facets, facets)
    {:noreply, socket}
  end
  def handle_params(%{"q" => query}, _uri, socket) do
    {:ok, results} = DigitalCollex.Search.query(query, %{})
    socket = socket
             |> assign(:q, query)
             |> assign(:results, results)
             |> assign(:selected_facets, %{})
    {:noreply, socket}
  end

  defp remove_empty_strings(facets) do
    facets
    |> Enum.reduce(%{}, &remove_empty_facet_values/2)
  end

  defp remove_empty_facet_values({facet_key, values}, acc) do
    acc
    |> Map.put(facet_key, Enum.filter(values, fn(x) -> x != "" end))
  end

  def handle_event("search", params, socket) do
    {:noreply, live_redirect(socket, to: Routes.result_path(socket, __MODULE__, params))}
  end
end
