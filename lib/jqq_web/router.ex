defmodule JqqWeb.Router do
  use JqqWeb, :router

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

  scope "/", JqqWeb do
    pipe_through :browser

    get "/", PageController, :index

    forward "/api", Absinthe.Plug,
      schema: JqqWeb.Schema.Schema

    forward "/graphql", Absinthe.Plug.GraphiQL,
      schema: JqqWeb.Schema.Schema,
      socket: JqqWeb.UserSocket,
      interface: :simple
  end

  # Other scopes may use custom stacks.
  # scope "/api", JqqWeb do
  #   pipe_through :api
  # end
end
