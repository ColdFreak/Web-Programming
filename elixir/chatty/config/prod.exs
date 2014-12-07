use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     https: [port: 443,
#             keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#             certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :phoenix, Chatty.Router,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "EY/Wgi74OI9p9VAq3ZDwM0/cNoByRMYHg6jc1j9tKbk+5Bxc8qIwvmDA2d/loGbCE2rbXc27Eq2/rmDo4ZPXog=="

config :logger,
  level: :info
