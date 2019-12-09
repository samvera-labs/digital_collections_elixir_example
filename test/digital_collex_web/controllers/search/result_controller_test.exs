defmodule DigitalCollexWeb.Search.ResultControllerTest do
  use DigitalCollexWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get(conn, "/results?q=39_ParrotsandToucans")
    assert html_response(conn, 200) =~ "ParrotsandToucans"
    assert html_response(conn, 200) =~ "Showing 1 of 1 result(s)"
  end
end
