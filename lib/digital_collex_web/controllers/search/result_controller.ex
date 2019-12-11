defmodule DigitalCollexWeb.Search.ResultController do
  use DigitalCollexWeb, :controller

  def index(conn, %{"q" => query, "f" => facets_list}) do
    {:ok, results} = DigitalCollex.Search.query(query, facets_list)
    render(conn, "index.html", results: results)
  end

  # Trivial case where no facets are passed in the query
  def index(conn, %{"q" => query}) do
    {:ok, results} = DigitalCollex.Search.query(query)
    render(conn, "index.html", results: results)
  end

  def show(conn, %{"id" => id}) do
    # render(conn, "show.html", user: user)
  end
end
