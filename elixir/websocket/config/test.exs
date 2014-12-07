use Mix.Config

config :phoenix, Websocket.Router,
  http: [port: System.get_env("PORT") || 4001],
