defmodule DigitalCollexWeb.Search.ResultController do
  use DigitalCollexWeb, :controller

  def index(conn, %{"q" => query}) do
    {:ok, results} = DigitalCollex.Search.query(query)
    render(conn, "index.html", results: results)
  end

  def show(conn, %{"id" => id}) do
    # render(conn, "show.html", user: user)
  end
end
