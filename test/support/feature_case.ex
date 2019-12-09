defmodule DigitalCollexWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias DigitalCollex.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import DigitalCollexWeb.Router.Helpers
    end
  end

  setup tags do

    :ok = Ecto.Adapters.SQL.Sandbox.checkout(DigitalCollex.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(DigitalCollex.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(DigitalCollex.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)

    {:ok, session: session}
  end
end
