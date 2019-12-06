defmodule DigitalCollexWeb.PowRoutes do
  use Pow.Phoenix.Routes

  @impl true
  def after_sign_out_path(_), do: "/"
end
