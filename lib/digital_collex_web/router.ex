defmodule DigitalCollexWeb.Router do
  use DigitalCollexWeb, :router
  use Pow.Phoenix.Router
  use PowAssent.Phoenix.Router

  pipeline :skip_csrf_protection do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :skip_csrf_protection

    pow_assent_authorization_post_callback_routes()
  end

  scope "/" do
    pipe_through :browser
    pow_routes()
    pow_assent_routes()
  end

  scope "/", DigitalCollexWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/results", Search.ResultController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", DigitalCollexWeb do
  #   pipe_through :api
  # end
end
