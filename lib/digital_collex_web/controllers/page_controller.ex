defmodule DigitalCollexWeb.PageController do
  use DigitalCollexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
