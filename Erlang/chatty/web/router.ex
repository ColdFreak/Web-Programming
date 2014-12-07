defmodule Chatty.Router do
  use Phoenix.Router
  use Phoenix.Router.Socket, mount: "/ws"

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", Chatty do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

  end

  channel "rooms", Chatty.Channels.Rooms

  # Other scopes may use custom stacks.
  # scope "/api", Chatty do
  #   pipe_through :api
  # end
end
