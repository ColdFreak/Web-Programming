# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the router
config :phoenix, Websocket.Router,
  url: [host: "localhost"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "EowndjwGShuI5tEz+qfo181PmlbLUgfd6LmV9CFRO5RDsW+bIdnJtKv5RfeCO6rV7FSiRFsqk1wHeMa4JGotBA==",
  debug_errors: false,
  error_controller: Websocket.PageController

# Session configuration
config :phoenix, Websocket.Router,
  session: [store: :cookie,
            key: "_websocket_key"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
