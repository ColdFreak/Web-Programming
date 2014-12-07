defmodule Websocket.Router do
  use Phoenix.Router
  use Phoenix.Router.Socket, mount: "/ws"

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", Websocket do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  channel "shell", Websocket.Channels.Shell

  # Other scopes may use custom stacks.
  # scope "/api", Websocket do
  #   pipe_through :api
  # end
end
