defmodule DigitalCollexWeb.Features.LandingPageTest do
  use DigitalCollexWeb.FeatureCase, async: true

  import Wallaby.Query, only: [css: 2]

  test "the LUX header is rendered on the landing page", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css(".lux h1", text: "Digital Collections at Northwinceton"))
  end
end
