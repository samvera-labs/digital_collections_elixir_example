defmodule DigitalCollexWeb.PageControllerTest do
  use DigitalCollexWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Digital Collections"
  end
end
