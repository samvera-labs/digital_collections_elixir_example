defmodule DigitalCollex.Repo do
  use Ecto.Repo,
    otp_app: :digital_collex,
    adapter: Ecto.Adapters.Postgres
end
